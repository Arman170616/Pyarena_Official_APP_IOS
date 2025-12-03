//
//  ChatbotView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI

import Combine
struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

struct ChatbotView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messages: [ChatMessage] = [
        ChatMessage(content: "Hello! I'm your AI assistant. How can I help you today?", isUser: false, timestamp: Date())
    ]
    @State private var inputText = ""
    @State private var isTyping = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Messages List
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(messages) { message in
                                ChatBubble(message: message)
                                    .id(message.id)
                            }
                            
                            if isTyping {
                                TypingIndicator()
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) { _, _ in
                        if let lastMessage = messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                Divider()
                
                // Input Area
                HStack(spacing: 12) {
                    TextField("Type your message...", text: $inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(inputText.isEmpty ? Color.gray : Color.blue)
                            .cornerRadius(22)
                    }
                    .disabled(inputText.isEmpty)
                }
                .padding()
            }
            .navigationTitle("AI Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func sendMessage() {
        let userMessage = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userMessage.isEmpty else { return }
        
        // Add user message
        messages.append(ChatMessage(content: userMessage, isUser: true, timestamp: Date()))
        inputText = ""
        
        // Simulate AI response
        isTyping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isTyping = false
            let response = generateResponse(for: userMessage)
            messages.append(ChatMessage(content: response, isUser: false, timestamp: Date()))
        }
    }
    
    private func generateResponse(for message: String) -> String {
        let lowercased = message.lowercased()
        
        if lowercased.contains("admission") || lowercased.contains("enroll") {
            return "Our admissions are open year-round! You can visit our schools page to find the nearest school and contact them directly for enrollment details."
        } else if lowercased.contains("program") || lowercased.contains("course") {
            return "We offer various programs for different age groups. Check out our Programs section to see all available options and their details."
        } else if lowercased.contains("fee") || lowercased.contains("cost") || lowercased.contains("price") {
            return "Our fees vary by program and school. Please visit the Programs section or contact the specific school for detailed fee information."
        } else if lowercased.contains("teacher") || lowercased.contains("faculty") {
            return "We have highly qualified teachers across all subjects. You can browse our Teachers Portfolio to learn more about our faculty members."
        } else if lowercased.contains("activity") || lowercased.contains("sport") {
            return "We offer a wide range of activities including sports, arts, and cultural programs. Check out our Activities section for more details!"
        } else if lowercased.contains("contact") || lowercased.contains("phone") || lowercased.contains("email") {
            return "You can reach us at +1 (555) 123-4567 or email us at info@schoolsystem.edu. Visit our Contact page for more information."
        } else if lowercased.contains("hello") || lowercased.contains("hi") {
            return "Hello! How can I assist you with your educational needs today?"
        } else {
            return "Thank you for your question! For specific information, please explore our app sections or contact us directly. Is there anything specific I can help you with?"
        }
    }
}

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 5) {
                Text(message.content)
                    .padding(12)
                    .background(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(message.isUser ? .white : .primary)
                    .cornerRadius(15)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: 250, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser {
                Spacer()
            }
        }
    }
}

struct TypingIndicator: View {
    @State private var numberOfDots = 0
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                        .opacity(numberOfDots > index ? 1 : 0.3)
                }
            }
            .padding(12)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
            
            Spacer()
        }
        .onReceive(timer) { _ in
            numberOfDots = (numberOfDots + 1) % 4
        }
    }
}

#Preview {
    ChatbotView()
}
