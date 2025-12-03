//
//  HomeView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var schools: [School]
    @Query private var news: [NewsArticle]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Hero Section
                    HeroSectionView()
                    
                    // Featured Schools
                    FeaturedSchoolsSection(schools: schools)
                    
                    // Latest News
                    LatestNewsSection(news: Array(news.prefix(3)))
                    
                    // Quick Links
                    QuickLinksSection()
                    
                    // Chatbot Button
                    ChatbotButtonView()
                }
                .padding()
            }
            .navigationTitle("School Management")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct HeroSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome to Our School System")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Empowering Education with AI Technology")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Image(systemName: "graduationcap.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .purple.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(15)
    }
}

struct FeaturedSchoolsSection: View {
    let schools: [School]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Our Schools")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: SchoolsListView()) {
                    Text("View All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            
            if schools.isEmpty {
                EmptyStateView(message: "No schools available", icon: "building.2")
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(schools.prefix(5)) { school in
                            SchoolCardView(school: school)
                        }
                    }
                }
            }
        }
    }
}

struct SchoolCardView: View {
    let school: School
    
    var body: some View {
        NavigationLink(destination: SchoolDetailView(school: school)) {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: "building.2.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                
                Text(school.name)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(school.address)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text("Est. \(school.establishedYear)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(width: 180, height: 180)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct LatestNewsSection: View {
    let news: [NewsArticle]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Latest News")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: NewsListView()) {
                    Text("View All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            
            if news.isEmpty {
                EmptyStateView(message: "No news available", icon: "newspaper")
            } else {
                VStack(spacing: 10) {
                    ForEach(news) { article in
                        NewsCardView(article: article)
                    }
                }
            }
        }
    }
}

struct NewsCardView: View {
    let article: NewsArticle
    
    var body: some View {
        NavigationLink(destination: NewsDetailView(article: article)) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "newspaper.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.orange)
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(article.title)
                        .font(.headline)
                        .lineLimit(2)
                    
                    Text(article.content)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    Text(article.publishedDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct QuickLinksSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Quick Links")
                .font(.title2)
                .fontWeight(.bold)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                QuickLinkButton(title: "Activities", icon: "figure.run", destination: AnyView(ActivitiesView()))
                QuickLinkButton(title: "Careers", icon: "briefcase.fill", destination: AnyView(CareersView()))
                QuickLinkButton(title: "Contact", icon: "phone.fill", destination: AnyView(ContactView()))
                QuickLinkButton(title: "Admin", icon: "lock.shield.fill", destination: AnyView(AdminLoginView()))
            }
        }
    }
}

struct QuickLinkButton: View {
    let title: String
    let icon: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
        }
    }
}

struct ChatbotButtonView: View {
    @State private var showChatbot = false
    
    var body: some View {
        Button(action: {
            showChatbot = true
        }) {
            HStack {
                Image(systemName: "message.fill")
                    .font(.title2)
                
                Text("Chat with AI Assistant")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .sheet(isPresented: $showChatbot) {
            ChatbotView()
        }
    }
}

struct EmptyStateView: View {
    let message: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [School.self, NewsArticle.self], inMemory: true)
}
