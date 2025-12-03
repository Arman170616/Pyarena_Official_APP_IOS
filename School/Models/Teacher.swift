//
//  Teacher.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import Foundation
import SwiftData

@Model
final class Teacher {
    var id: UUID
    var name: String
    var subject: String
    var qualification: String
    var experience: Int
    var bio: String
    var email: String
    var phoneNumber: String
    var profileImageName: String?
    var timestamp: Date
    
    init(name: String, subject: String, qualification: String, experience: Int, bio: String, email: String, phoneNumber: String, profileImageName: String? = nil) {
        self.id = UUID()
        self.name = name
        self.subject = subject
        self.qualification = qualification
        self.experience = experience
        self.bio = bio
        self.email = email
        self.phoneNumber = phoneNumber
        self.profileImageName = profileImageName
        self.timestamp = Date()
    }
}
