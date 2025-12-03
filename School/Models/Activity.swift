//
//  Activity.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import Foundation
import SwiftData

@Model
final class Activity {
    var id: UUID
    var title: String
    var activityDescription: String
    var category: String // Sports, Arts, Cultural, Academic
    var schedule: String
    var location: String
    var imageNames: [String]
    var timestamp: Date
    
    init(title: String, activityDescription: String, category: String, schedule: String, location: String, imageNames: [String] = []) {
        self.id = UUID()
        self.title = title
        self.activityDescription = activityDescription
        self.category = category
        self.schedule = schedule
        self.location = location
        self.imageNames = imageNames
        self.timestamp = Date()
    }
}
