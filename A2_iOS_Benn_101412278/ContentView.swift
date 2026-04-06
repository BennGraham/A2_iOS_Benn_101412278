//
//  ContentView.swift
//  A2_iOS_Benn_101412278
//
//  Created by Benn Graham on 2026-03-29.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                ProductDetailView()
            }
            .tabItem {
                Label("Browse", systemImage: "tag")
            }
            NavigationView {
                ProductListView()
            }
            .tabItem {
                Label("Products", systemImage: "list.bullet")
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
