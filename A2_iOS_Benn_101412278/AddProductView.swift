//
//  AddProductView.swift
//  A2_iOS_Benn_101412278
//
//  Created by Benn Graham on 2026-04-07.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var provider: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add Product")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Price", text: $price)
                    TextField("Provider", text: $provider)
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button ("Save") { save() }
                        .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func save() {
        let new = Product(context: viewContext)
        new.productId = UUID()
        new.productName = name
        new.productDescription = description
        new.productPrice = Double(price) ?? 0.0
        new.productProvider = provider
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}
