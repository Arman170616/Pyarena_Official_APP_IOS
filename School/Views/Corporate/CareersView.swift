//
//  CareersView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct CareersView: View {
    @Query private var careers: [Career]
    @State private var selectedJobType = "All"
    
    let jobTypes = ["All", "Full-time", "Part-time", "Contract"]
    
    var filteredCareers: [Career] {
        let activeCareers = careers.filter { $0.isActive }
        
        if selectedJobType == "All" {
            return activeCareers
        }
        return activeCareers.filter { $0.jobType == selectedJobType }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Job Type Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(jobTypes, id: \.self) { type in
                            CategoryChip(
                                title: type,
                                isSelected: selectedJobType == type
                            ) {
                                withAnimation {
                                    selectedJobType = type
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                // Career Listings
                if filteredCareers.isEmpty {
                    EmptyStateView(message: "No job openings available", icon: "briefcase")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredCareers) { career in
                                CareerCardView(career: career)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Careers")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddCareerView()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct CareerCardView: View {
    let career: Career
    
    var body: some View {
        NavigationLink(destination: CareerDetailView(career: career)) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "briefcase.fill")
                        .font(.title2)
                        .foregroundColor(.purple)
                    
                    Spacer()
                    
                    Text(career.jobType)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.purple.opacity(0.2))
                        .foregroundColor(.purple)
                        .cornerRadius(8)
                }
                
                Text(career.jobTitle)
                    .font(.headline)
                
                Text(career.department)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 15) {
                    InfoBadge(icon: "mappin", text: career.location)
                    InfoBadge(icon: "dollarsign.circle", text: career.salary)
                }
                
                Text("Posted: \(career.postedDate, style: .date)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CareerDetailView: View {
    let career: Career
    @State private var showingApplicationForm = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text(career.jobTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 15) {
                        Label(career.department, systemImage: "building.2")
                        Label(career.location, systemImage: "mappin")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.purple.opacity(0.1))
                .cornerRadius(15)
                
                // Job Details
                VStack(alignment: .leading, spacing: 12) {
                    DetailRow(icon: "briefcase.fill", title: "Job Type", value: career.jobType)
                    DetailRow(icon: "dollarsign.circle.fill", title: "Salary", value: career.salary)
                    DetailRow(icon: "calendar", title: "Posted", value: career.postedDate.formatted(date: .long, time: .omitted))
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Description
                VStack(alignment: .leading, spacing: 10) {
                    Text("Job Description")
                        .font(.headline)
                    
                    Text(career.jobDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                // Requirements
                VStack(alignment: .leading, spacing: 10) {
                    Text("Requirements")
                        .font(.headline)
                    
                    ForEach(career.requirements, id: \.self) { requirement in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            
                            Text(requirement)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Apply Button
                Button(action: {
                    showingApplicationForm = true
                }) {
                    Text("Apply Now")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingApplicationForm) {
            JobApplicationView(career: career)
        }
    }
}

struct JobApplicationView: View {
    let career: Career
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var coverLetter = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Information") {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                Section("Cover Letter") {
                    TextField("Tell us why you're a great fit...", text: $coverLetter, axis: .vertical)
                        .lineLimit(5...10)
                }
                
                Section {
                    Button(action: submitApplication) {
                        Text("Submit Application")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.blue)
                    }
                    .disabled(fullName.isEmpty || email.isEmpty)
                }
            }
            .navigationTitle("Apply for \(career.jobTitle)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func submitApplication() {
        // Handle application submission
        dismiss()
    }
}

struct AddCareerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var jobTitle = ""
    @State private var department = ""
    @State private var location = ""
    @State private var jobType = "Full-time"
    @State private var jobDescription = ""
    @State private var requirements = ""
    @State private var salary = ""
    
    let jobTypes = ["Full-time", "Part-time", "Contract"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Job Information") {
                    TextField("Job Title", text: $jobTitle)
                    TextField("Department", text: $department)
                    TextField("Location", text: $location)
                    
                    Picker("Job Type", selection: $jobType) {
                        ForEach(jobTypes, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                }
                
                Section("Description") {
                    TextField("Job Description", text: $jobDescription, axis: .vertical)
                        .lineLimit(4...8)
                }
                
                Section("Requirements") {
                    TextField("Requirements (one per line)", text: $requirements, axis: .vertical)
                        .lineLimit(4...8)
                }
                
                Section("Compensation") {
                    TextField("Salary Range", text: $salary)
                }
            }
            .navigationTitle("Post Job Opening")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        saveCareer()
                    }
                    .disabled(jobTitle.isEmpty)
                }
            }
        }
    }
    
    private func saveCareer() {
        let requirementsList = requirements.components(separatedBy: "\n").filter { !$0.isEmpty }
        
        let career = Career(
            jobTitle: jobTitle,
            department: department,
            location: location,
            jobType: jobType,
            jobDescription: jobDescription,
            requirements: requirementsList,
            salary: salary,
            postedDate: Date()
        )
        modelContext.insert(career)
        dismiss()
    }
}

#Preview {
    CareersView()
        .modelContainer(for: Career.self, inMemory: true)
}
