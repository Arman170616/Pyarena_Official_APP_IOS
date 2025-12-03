//
//  AdminLoginView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI

struct AdminLoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Logo
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("Admin Panel")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Enter your credentials to access the admin panel")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    // Login Form
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .frame(width: 25)
                            
                            TextField("Username", text: $username)
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                                .frame(width: 25)
                            
                            SecureField("Password", text: $password)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        
                        Button(action: login) {
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                Text("Login")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(username.isEmpty || password.isEmpty)
                    }
                    
                    // Role Information
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Access Levels:")
                            .font(.headline)
                        
                        AccessLevelRow(icon: "star.fill", title: "Super Admin", description: "Full system access", color: .purple)
                        AccessLevelRow(icon: "person.badge.key.fill", title: "School Admin", description: "School-specific management", color: .blue)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(15)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Admin Login")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Login Failed", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Invalid username or password. Please try again.")
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                AdminDashboardView()
            }
        }
    }
    
    private func login() {
        // Simple authentication (in production, use proper authentication)
        if username == "admin" && password == "admin123" {
            isLoggedIn = true
        } else {
            showingAlert = true
        }
    }
}

struct AccessLevelRow: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct AdminDashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Admin Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Welcome to the Admin Panel")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    DashboardCard(icon: "building.2.fill", title: "Schools", count: "3", color: .blue)
                    DashboardCard(icon: "person.3.fill", title: "Teachers", count: "50+", color: .green)
                    DashboardCard(icon: "book.fill", title: "Programs", count: "12", color: .orange)
                    DashboardCard(icon: "newspaper.fill", title: "News", count: "25", color: .red)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Quick Actions")
                        .font(.headline)
                    
                    NavigationLink(destination: Text("Manage Schools")) {
                        AdminActionRow(icon: "building.2.fill", title: "Manage Schools", color: .blue)
                    }
                    
                    NavigationLink(destination: Text("Manage Users")) {
                        AdminActionRow(icon: "person.3.fill", title: "Manage Users", color: .green)
                    }
                    
                    NavigationLink(destination: Text("System Settings")) {
                        AdminActionRow(icon: "gearshape.fill", title: "System Settings", color: .gray)
                    }
                    
                    NavigationLink(destination: Text("Reports")) {
                        AdminActionRow(icon: "chart.bar.fill", title: "View Reports", color: .purple)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
    }
}

struct DashboardCard: View {
    let icon: String
    let title: String
    let count: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(count)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct AdminActionRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(color)
                .cornerRadius(8)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    AdminLoginView()
}
