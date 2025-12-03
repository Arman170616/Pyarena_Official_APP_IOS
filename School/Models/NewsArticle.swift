//
//  NewsArticle.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import Foundation
import SwiftData

@Model
final class NewsArticle {
    var id: UUID
    var title: String
    var content: String
    var author: String
    var publishedDate: Date
    var category: String
    var imageNames: [String]
    var timestamp: Date
    
    init(title: String, content: String, author: String, publishedDate: Date, category: String, imageNames: [String] = []) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.author = author
        self.publishedDate = publishedDate
        self.category = category
        self.imageNames = imageNames
        self.timestamp = Date()
    }
}
