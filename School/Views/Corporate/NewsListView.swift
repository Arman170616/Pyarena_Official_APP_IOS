//
//  NewsListView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct NewsListView: View {
    @Query(sort: \NewsArticle.publishedDate, order: .reverse) private var news: [NewsArticle]
    @State private var selectedCategory = "All"
    
    var categories: [String] {
        var allCategories = Set(news.map { $0.category })
        allCategories.insert("All")
        return Array(allCategories).sorted()
    }
    
    var filteredNews: [NewsArticle] {
        if selectedCategory == "All" {
            return news
        }
        return news.filter { $0.category == selectedCategory }
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
                
                // News List
                if filteredNews.isEmpty {
                    EmptyStateView(message: "No news articles available", icon: "newspaper")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredNews) { article in
                                NewsCardView(article: article)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("News & Updates")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNewsView()) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

struct NewsDetailView: View {
    let article: NewsArticle
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Image
                Image(systemName: "newspaper.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(15)
                
                // Article Info
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.category)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(8)
                    
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Label(article.author, systemImage: "person.fill")
                        Spacer()
                        Label(article.publishedDate.formatted(date: .long, time: .omitted), systemImage: "calendar")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Content
                Text(article.content)
                    .font(.body)
                    .lineSpacing(8)
                
                // Share Button
                Button(action: {
                    // Handle sharing
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share Article")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddNewsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var content = ""
    @State private var author = ""
    @State private var category = "General"
    @State private var publishedDate = Date()
    
    let categories = ["General", "Academic", "Sports", "Events", "Announcements"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Article Information") {
                    TextField("Title", text: $title)
                    
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                    
                    TextField("Author", text: $author)
                    
                    DatePicker("Published Date", selection: $publishedDate, displayedComponents: .date)
                }
                
                Section("Content") {
                    TextField("Article Content", text: $content, axis: .vertical)
                        .lineLimit(10...20)
                }
            }
            .navigationTitle("Add News Article")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Publish") {
                        saveNews()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
    
    private func saveNews() {
        let article = NewsArticle(
            title: title,
            content: content,
            author: author,
            publishedDate: publishedDate,
            category: category
        )
        modelContext.insert(article)
        dismiss()
    }
}

#Preview {
    NewsListView()
        .modelContainer(for: NewsArticle.self, inMemory: true)
}
