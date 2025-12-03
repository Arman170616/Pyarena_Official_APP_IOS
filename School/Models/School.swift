//
//  School.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import Foundation
import SwiftData

@Model
final class School {
    var id: UUID
    var name: String
    var address: String
    var phoneNumber: String
    var email: String
    var schoolDescription: String
    var logoImageName: String?
    var establishedYear: Int
    var timestamp: Date
    
    init(name: String, address: String, phoneNumber: String, email: String, schoolDescription: String, logoImageName: String? = nil, establishedYear: Int) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.email = email
        self.schoolDescription = schoolDescription
        self.logoImageName = logoImageName
        self.establishedYear = establishedYear
        self.timestamp = Date()
    }
}
