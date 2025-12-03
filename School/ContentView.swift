//
//  ContentView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        CorporateHomeView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [School.self, Teacher.self, NewsArticle.self, Program.self, Activity.self, Career.self], inMemory: true)
}
