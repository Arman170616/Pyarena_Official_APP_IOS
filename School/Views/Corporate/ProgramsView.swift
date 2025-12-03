//
//  ProgramsView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct ProgramsView: View {
    @Query private var programs: [Program]
    @State private var selectedCategory = "All"
    
    let categories = ["All", "Primary", "Secondary", "Advanced"]
    
    var filteredPrograms: [Program] {
        if selectedCategory == "All" {
            return programs
        }
        return programs.filter { $0.ageGroup.contains(selectedCategory) }
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
                .background(Color.gray.opacity(0.05))
                
                // Programs List
                if filteredPrograms.isEmpty {
                    EmptyStateView(message: "No programs available", icon: "book.closed")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredPrograms) { program in
                                ProgramCardView(program: program)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Programs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddProgramView()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct ProgramCardView: View {
    let program: Program
    
    var body: some View {
        NavigationLink(destination: ProgramDetailView(program: program)) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "book.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text(String(format: "$%.0f", program.fee))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Text(program.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(program.programDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                HStack(spacing: 20) {
                    InfoBadge(icon: "clock", text: program.duration)
                    InfoBadge(icon: "person.2", text: program.ageGroup)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct InfoBadge: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.blue.opacity(0.1))
        .foregroundColor(.blue)
        .cornerRadius(8)
    }
}

struct ProgramDetailView: View {
    let program: Program
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Image
                Image(systemName: "book.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
                
                // Program Info
                VStack(alignment: .leading, spacing: 10) {
                    Text(program.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(program.programDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                // Details Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    DetailCard(icon: "clock", title: "Duration", value: program.duration)
                    DetailCard(icon: "person.2", title: "Age Group", value: program.ageGroup)
                    DetailCard(icon: "dollarsign.circle", title: "Fee", value: String(format: "$%.0f", program.fee))
                    DetailCard(icon: "book", title: "Curriculum", value: program.curriculum)
                }
                
                Spacer(minLength: 20)
                
                // Enroll Button
                Button(action: {
                    // Handle enrollment
                }) {
                    Text("Enroll Now")
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
        .navigationTitle("Program Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct AddProgramView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var description = ""
    @State private var duration = ""
    @State private var ageGroup = ""
    @State private var fee = ""
    @State private var curriculum = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Program Information") {
                    TextField("Program Name", text: $name)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Details") {
                    TextField("Duration (e.g., 1 Year)", text: $duration)
                    TextField("Age Group", text: $ageGroup)
                    TextField("Fee", text: $fee)
                        .keyboardType(.decimalPad)
                    TextField("Curriculum", text: $curriculum)
                }
            }
            .navigationTitle("Add Program")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveProgram()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func saveProgram() {
        let program = Program(
            name: name,
            programDescription: description,
            duration: duration,
            ageGroup: ageGroup,
            fee: Double(fee) ?? 0,
            curriculum: curriculum
        )
        modelContext.insert(program)
        dismiss()
    }
}

#Preview {
    ProgramsView()
        .modelContainer(for: Program.self, inMemory: true)
}
