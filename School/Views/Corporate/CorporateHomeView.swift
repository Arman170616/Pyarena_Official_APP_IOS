//
//  CorporateHomeView.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import SwiftUI

struct CorporateHomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle.fill")
                }
                .tag(1)
            
            ProgramsView()
                .tabItem {
                    Label("Programs", systemImage: "book.fill")
                }
                .tag(2)
            
            TeachersView()
                .tabItem {
                    Label("Teachers", systemImage: "person.3.fill")
                }
                .tag(3)
            
            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis.circle.fill")
                }
                .tag(4)
        }
    }
}

#Preview {
    CorporateHomeView()
}
