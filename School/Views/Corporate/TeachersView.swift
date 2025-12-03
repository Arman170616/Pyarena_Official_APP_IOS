//
//  TeachersView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct TeachersView: View {
    @Query private var teachers: [Teacher]
    @State private var searchText = ""
    @State private var selectedSubject = "All"
    
    var subjects: [String] {
        var allSubjects = Set(teachers.map { $0.subject })
        allSubjects.insert("All")
        return Array(allSubjects).sorted()
    }
    
    var filteredTeachers: [Teacher] {
        var result = teachers
        
        if selectedSubject != "All" {
            result = result.filter { $0.subject == selectedSubject }
        }
        
        if !searchText.isEmpty {
            result = result.filter { 
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.subject.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search teachers...", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
                
                // Subject Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(subjects, id: \.self) { subject in
                            CategoryChip(
                                title: subject,
                                isSelected: selectedSubject == subject
                            ) {
                                withAnimation {
                                    selectedSubject = subject
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
                // Teachers Grid
                if filteredTeachers.isEmpty {
                    EmptyStateView(message: "No teachers found", icon: "person.3")
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(filteredTeachers) { teacher in
                                TeacherCardView(teacher: teacher)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Teachers Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddTeacherView()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct TeacherCardView: View {
    let teacher: Teacher
    
    var body: some View {
        NavigationLink(destination: TeacherDetailView(teacher: teacher)) {
            VStack(spacing: 12) {
                // Profile Image
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                // Name
                Text(teacher.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                // Subject Badge
                Text(teacher.subject)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
                
                // Experience
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.orange)
                    Text("\(teacher.experience) years")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TeacherDetailView: View {
    let teacher: Teacher
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Header
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 120))
                        .foregroundColor(.blue)
                    
                    Text(teacher.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(teacher.subject)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                
                // Quick Info
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    InfoCard(icon: "graduationcap.fill", title: "Qualification", value: teacher.qualification)
                    InfoCard(icon: "calendar", title: "Experience", value: "\(teacher.experience) years")
                }
                
                // Bio Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.blue)
                        Text("Biography")
                            .font(.headline)
                    }
                    
                    Text(teacher.bio)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Contact Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                        Text("Contact Information")
                            .font(.headline)
                    }
                    
                    ContactRow(icon: "envelope.fill", text: teacher.email)
                    ContactRow(icon: "phone.fill", text: teacher.phoneNumber)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ContactRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)
            
            Text(text)
                .font(.subheadline)
            
            Spacer()
        }
    }
}

struct AddTeacherView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var subject = ""
    @State private var qualification = ""
    @State private var experience = ""
    @State private var bio = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    TextField("Full Name", text: $name)
                    TextField("Subject", text: $subject)
                    TextField("Qualification", text: $qualification)
                    TextField("Years of Experience", text: $experience)
                        .keyboardType(.numberPad)
                }
                
                Section("Biography") {
                    TextField("Bio", text: $bio, axis: .vertical)
                        .lineLimit(4...8)
                }
                
                Section("Contact") {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }
            }
            .navigationTitle("Add Teacher")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTeacher()
                    }
                    .disabled(name.isEmpty || subject.isEmpty)
                }
            }
        }
    }
    
    private func saveTeacher() {
        let teacher = Teacher(
            name: name,
            subject: subject,
            qualification: qualification,
            experience: Int(experience) ?? 0,
            bio: bio,
            email: email,
            phoneNumber: phoneNumber
        )
        modelContext.insert(teacher)
        dismiss()
    }
}

#Preview {
    TeachersView()
        .modelContainer(for: Teacher.self, inMemory: true)
}
