//
//  SchoolsListView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct SchoolsListView: View {
    @Query private var schools: [School]
    @State private var searchText = ""
    
    var filteredSchools: [School] {
        if searchText.isEmpty {
            return schools
        }
        return schools.filter { 
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.address.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search schools...", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
                
                // Schools List
                if filteredSchools.isEmpty {
                    EmptyStateView(message: "No schools available", icon: "building.2")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredSchools) { school in
                                SchoolListCardView(school: school)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Our Schools")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddSchoolView()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct SchoolListCardView: View {
    let school: School
    
    var body: some View {
        NavigationLink(destination: SchoolDetailView(school: school)) {
            HStack(spacing: 15) {
                // Logo
                Image(systemName: "building.2.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                    .frame(width: 70, height: 70)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                
                // Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(school.name)
                        .font(.headline)
                        .lineLimit(2)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(school.address)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    HStack(spacing: 15) {
                        Label("\(school.establishedYear)", systemImage: "calendar")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Label(school.phoneNumber, systemImage: "phone.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SchoolDetailView: View {
    let school: School
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "building.2.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                    
                    Text(school.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Established \(school.establishedYear)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                
                // About Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.headline)
                    
                    Text(school.schoolDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                // Contact Information
                VStack(alignment: .leading, spacing: 12) {
                    Text("Contact Information")
                        .font(.headline)
                    
                    ContactRow(icon: "mappin.circle.fill", text: school.address)
                    ContactRow(icon: "phone.fill", text: school.phoneNumber)
                    ContactRow(icon: "envelope.fill", text: school.email)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Quick Actions
                VStack(spacing: 12) {
                    ActionButton(title: "View Programs", icon: "book.fill", color: .blue) {
                        // Navigate to programs
                    }
                    
                    ActionButton(title: "Meet Our Teachers", icon: "person.3.fill", color: .green) {
                        // Navigate to teachers
                    }
                    
                    ActionButton(title: "School Activities", icon: "figure.run", color: .orange) {
                        // Navigate to activities
                    }
                    
                    ActionButton(title: "Contact School", icon: "phone.circle.fill", color: .purple) {
                        // Contact action
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.white)
            .padding()
            .background(color)
            .cornerRadius(10)
        }
    }
}

struct AddSchoolView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var address = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var schoolDescription = ""
    @State private var establishedYear = String(Calendar.current.component(.year, from: Date()))
    
    var body: some View {
        NavigationStack {
            Form {
                Section("School Information") {
                    TextField("School Name", text: $name)
                    TextField("Address", text: $address)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section("Details") {
                    TextField("Established Year", text: $establishedYear)
                        .keyboardType(.numberPad)
                    
                    TextField("Description", text: $schoolDescription, axis: .vertical)
                        .lineLimit(4...8)
                }
            }
            .navigationTitle("Add School")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveSchool()
                    }
                    .disabled(name.isEmpty || address.isEmpty)
                }
            }
        }
    }
    
    private func saveSchool() {
        let school = School(
            name: name,
            address: address,
            phoneNumber: phoneNumber,
            email: email,
            schoolDescription: schoolDescription,
            establishedYear: Int(establishedYear) ?? 2000
        )
        modelContext.insert(school)
        dismiss()
    }
}

#Preview {
    SchoolsListView()
        .modelContainer(for: School.self, inMemory: true)
}
