//
//  ContactView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI

struct ContactView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var subject = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: "envelope.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        Text("Get in Touch")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("We'd love to hear from you. Send us a message and we'll respond as soon as possible.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
                    
                    // Contact Information
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Contact Information")
                            .font(.headline)
                        
                        ContactInfoCard(icon: "phone.fill", title: "Phone", value: "+1 (555) 123-4567", color: .green)
                        ContactInfoCard(icon: "envelope.fill", title: "Email", value: "info@schoolsystem.edu", color: .blue)
                        ContactInfoCard(icon: "mappin.circle.fill", title: "Address", value: "123 Education Street, City, State 12345", color: .red)
                        ContactInfoCard(icon: "clock.fill", title: "Office Hours", value: "Mon-Fri: 8:00 AM - 5:00 PM", color: .orange)
                    }
                    
                    // Contact Form
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Send us a Message")
                            .font(.headline)
                        
                        VStack(spacing: 15) {
                            FormField(icon: "person.fill", placeholder: "Your Name", text: $name)
                            FormField(icon: "envelope.fill", placeholder: "Your Email", text: $email)
                            FormField(icon: "tag.fill", placeholder: "Subject", text: $subject)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "message.fill")
                                        .foregroundColor(.gray)
                                    Text("Message")
                                        .foregroundColor(.gray)
                                }
                                .font(.subheadline)
                                
                                TextField("Your message here...", text: $message, axis: .vertical)
                                    .lineLimit(5...10)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                            }
                        }
                        
                        Button(action: sendMessage) {
                            HStack {
                                Image(systemName: "paperplane.fill")
                                Text("Send Message")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(name.isEmpty || email.isEmpty || message.isEmpty)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(15)
                    
                    // Social Media
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Follow Us")
                            .font(.headline)
                        
                        HStack(spacing: 20) {
                            SocialMediaButton(icon: "link", color: .blue)
                            SocialMediaButton(icon: "link", color: .blue)
                            SocialMediaButton(icon: "link", color: .blue)
                            SocialMediaButton(icon: "link", color: .blue)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Contact Us")
            .alert("Message Sent", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    clearForm()
                }
            } message: {
                Text("Thank you for contacting us. We'll get back to you soon!")
            }
        }
    }
    
    private func sendMessage() {
        // Handle message sending
        showingAlert = true
    }
    
    private func clearForm() {
        name = ""
        email = ""
        subject = ""
        message = ""
    }
}

struct ContactInfoCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct FormField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct SocialMediaButton: View {
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Handle social media link
        }) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .cornerRadius(10)
        }
    }
}

#Preview {
    ContactView()
}
