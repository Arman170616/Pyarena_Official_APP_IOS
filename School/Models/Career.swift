//
//  Career.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import Foundation
import SwiftData

@Model
final class Career {
    var id: UUID
    var jobTitle: String
    var department: String
    var location: String
    var jobType: String // Full-time, Part-time, Contract
    var jobDescription: String
    var requirements: [String]
    var salary: String
    var postedDate: Date
    var isActive: Bool
    var timestamp: Date
    
    init(jobTitle: String, department: String, location: String, jobType: String, jobDescription: String, requirements: [String], salary: String, postedDate: Date, isActive: Bool = true) {
        self.id = UUID()
        self.jobTitle = jobTitle
        self.department = department
        self.location = location
        self.jobType = jobType
        self.jobDescription = jobDescription
        self.requirements = requirements
        self.salary = salary
        self.postedDate = postedDate
        self.isActive = isActive
        self.timestamp = Date()
    }
}
