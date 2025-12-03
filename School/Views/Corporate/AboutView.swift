//
//  AboutView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    // Mission Section
                    SectionCard(
                        title: "Our Mission",
                        icon: "target",
                        content: "To provide world-class education that empowers students to reach their full potential and become responsible global citizens.",
                        color: .blue
                    )
                    
                    // Vision Section
                    SectionCard(
                        title: "Our Vision",
                        icon: "eye.fill",
                        content: "To be a leading educational institution that transforms lives through innovative teaching methods and AI-powered learning solutions.",
                        color: .purple
                    )
                    
                    // Values Section
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                                .font(.title2)
                            Text("Our Values")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        ValuesItemView(icon: "checkmark.seal.fill", title: "Excellence", description: "Striving for the highest standards in everything we do")
                        ValuesItemView(icon: "heart.fill", title: "Integrity", description: "Building trust through honest and ethical practices")
                        ValuesItemView(icon: "person.3.fill", title: "Collaboration", description: "Working together to achieve common goals")
                        ValuesItemView(icon: "lightbulb.fill", title: "Innovation", description: "Embracing new ideas and technologies")
                        ValuesItemView(icon: "leaf.fill", title: "Sustainability", description: "Creating a better future for generations to come")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    
                    // Statistics Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Our Impact")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            StatisticCard(value: "3", label: "Schools", icon: "building.2.fill", color: .blue)
                            StatisticCard(value: "500+", label: "Students", icon: "person.3.fill", color: .green)
                            StatisticCard(value: "50+", label: "Teachers", icon: "person.fill", color: .orange)
                            StatisticCard(value: "20+", label: "Years", icon: "calendar", color: .purple)
                        }
                    }
                    
                    // Leadership Section
                    LeadershipSectionView()
                }
                .padding()
            }
            .navigationTitle("About Us")
        }
    }
}

struct SectionCard: View {
    let title: String
    let icon: String
    let content: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title2)
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(5)
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(15)
    }
}

struct ValuesItemView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct StatisticCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct LeadershipSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Leadership Team")
                .font(.title2)
                .fontWeight(.bold)
            
            LeaderCard(name: "Dr. Sarah Johnson", role: "Chief Executive Officer", icon: "person.circle.fill", color: .blue)
            LeaderCard(name: "Mr. Ahmed Khan", role: "Chief Academic Officer", icon: "person.circle.fill", color: .green)
            LeaderCard(name: "Ms. Maria Garcia", role: "Chief Technology Officer", icon: "person.circle.fill", color: .orange)
        }
    }
}

struct LeaderCard: View {
    let name: String
    let role: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.headline)
                
                Text(role)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    AboutView()
}
