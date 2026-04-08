//
//  ContentView.swift
//  A2_iOS_Benn_101412278
//
//  Created by Benn Graham on 2026-03-29.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    @State private var showModal = false

    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    NavigationLink {
                        ProductDetailView(currentProduct: product)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(product.productName ?? "Product name placeholder")
                            Text(product.productDescription ?? "")
                                .font(.system(size: 12))
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showModal = true
                    } label: {
                        Label("Add Product", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showModal) {
                AddProductView()
                    .environment(\.managedObjectContext, viewContext)
            }
            Text("Select a product")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

