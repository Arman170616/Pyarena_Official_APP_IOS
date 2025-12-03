//
//  MoreView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Engagement") {
                    NavigationLink(destination: ActivitiesView()) {
                        MenuRow(icon: "figure.run", title: "Activities", color: .orange)
                    }
                    
                    NavigationLink(destination: NewsListView()) {
                        MenuRow(icon: "newspaper.fill", title: "News", color: .red)
                    }
                    
                    NavigationLink(destination: CareersView()) {
                        MenuRow(icon: "briefcase.fill", title: "Careers", color: .purple)
                    }
                }
                
                Section("Information") {
                    NavigationLink(destination: SchoolsListView()) {
                        MenuRow(icon: "building.2.fill", title: "Our Schools", color: .blue)
                    }
                    
                    NavigationLink(destination: ContactView()) {
                        MenuRow(icon: "phone.fill", title: "Contact Us", color: .green)
                    }
                }
                
                Section("AI Assistant") {
                    NavigationLink(destination: ChatbotView()) {
                        MenuRow(icon: "message.fill", title: "Chat with AI", color: .teal)
                    }
                }
                
                Section("Administration") {
                    NavigationLink(destination: AdminLoginView()) {
                        MenuRow(icon: "lock.shield.fill", title: "Admin Panel", color: .gray)
                    }
                }
            }
            .navigationTitle("More")
        }
    }
}

struct MenuRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(color)
                .cornerRadius(8)
            
            Text(title)
                .font(.body)
        }
    }
}

#Preview {
    MoreView()
}
