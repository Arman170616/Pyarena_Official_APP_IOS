//
//  Program.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import Foundation
import SwiftData

@Model
final class Program {
    var id: UUID
    var name: String
    var programDescription: String
    var duration: String
    var ageGroup: String
    var fee: Double
    var curriculum: String
    var imageName: String?
    var timestamp: Date
    
    init(name: String, programDescription: String, duration: String, ageGroup: String, fee: Double, curriculum: String, imageName: String? = nil) {
        self.id = UUID()
        self.name = name
        self.programDescription = programDescription
        self.duration = duration
        self.ageGroup = ageGroup
        self.fee = fee
        self.curriculum = curriculum
        self.imageName = imageName
        self.timestamp = Date()
    }
}
