//
//  ActivitiesView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct ActivitiesView: View {
    @Query private var activities: [Activity]
    @State private var selectedCategory = "All"
    
    let categories = ["All", "Sports", "Arts", "Cultural", "Academic"]
    
    var filteredActivities: [Activity] {
        if selectedCategory == "All" {
            return activities
        }
        return activities.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryChip(
                                title: category,
                                isSelected: selectedCategory == category
                            ) {
                                withAnimation {
                                    selectedCategory = category
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                // Activities List
                if filteredActivities.isEmpty {
                    EmptyStateView(message: "No activities available", icon: "figure.run")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredActivities) { activity in
                                ActivityCardView(activity: activity)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Activities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddActivityView()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct ActivityCardView: View {
    let activity: Activity
    
    var categoryColor: Color {
        switch activity.category {
        case "Sports": return .green
        case "Arts": return .purple
        case "Cultural": return .orange
        case "Academic": return .blue
        default: return .gray
        }
    }
    
    var body: some View {
        NavigationLink(destination: ActivityDetailView(activity: activity)) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: categoryIcon)
                        .font(.system(size: 40))
                        .foregroundColor(categoryColor)
                    
                    Spacer()
                    
                    Text(activity.category)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(categoryColor.opacity(0.2))
                        .foregroundColor(categoryColor)
                        .cornerRadius(8)
                }
                
                Text(activity.title)
                    .font(.headline)
                
                Text(activity.activityDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 15) {
                    InfoBadge(icon: "clock", text: activity.schedule)
                    InfoBadge(icon: "mappin", text: activity.location)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    var categoryIcon: String {
        switch activity.category {
        case "Sports": return "sportscourt.fill"
        case "Arts": return "paintpalette.fill"
        case "Cultural": return "theatermasks.fill"
        case "Academic": return "book.fill"
        default: return "star.fill"
        }
    }
}

struct ActivityDetailView: View {
    let activity: Activity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "figure.run")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text(activity.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                
                // Description
                VStack(alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.headline)
                    
                    Text(activity.activityDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                // Details
                VStack(alignment: .leading, spacing: 12) {
                    DetailRow(icon: "tag.fill", title: "Category", value: activity.category)
                    DetailRow(icon: "clock.fill", title: "Schedule", value: activity.schedule)
                    DetailRow(icon: "mappin.circle.fill", title: "Location", value: activity.location)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Register Button
                Button(action: {
                    // Handle registration
                }) {
                    Text("Register for Activity")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

struct AddActivityView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var description = ""
    @State private var category = "Sports"
    @State private var schedule = ""
    @State private var location = ""
    
    let categories = ["Sports", "Arts", "Cultural", "Academic"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Activity Information") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                }
                
                Section("Details") {
                    TextField("Schedule (e.g., Mon-Fri 4-6 PM)", text: $schedule)
                    TextField("Location", text: $location)
                }
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveActivity()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveActivity() {
        let activity = Activity(
            title: title,
            activityDescription: description,
            category: category,
            schedule: schedule,
            location: location
        )
        modelContext.insert(activity)
        dismiss()
    }
}

#Preview {
    ActivitiesView()
        .modelContainer(for: Activity.self, inMemory: true)
}
