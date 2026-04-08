//
//  ProductDetailView.swift
//  A2_iOS_Benn_101412278
//
//  Created by Benn Graham on 2026-04-05.
//

import SwiftUI
import CoreData

struct ProductDetailView:  View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    var currentProduct: Product?
    @State private var currentIndex: Int = 0
    
    private var product: Product? {
        guard !products.isEmpty else { return nil }
        return products[currentIndex]
    }
    
    var body: some View {
        NavigationView {
            if let product = product {
                VStack() {
                    Text(product.productName ?? "Product name placeholder")
                    Text(product.productDescription ?? "Product descrition placeholder")
                    Text(String(product.productPrice))
                    Text(product.productProvider ?? "Product provider placeholder")
                    
                    HStack {
                        Button("Previous") { currentIndex -= 1 }
                            .disabled(currentIndex == 0)
                        Text("\(currentIndex + 1)/\(products.count)")
                        Button("Next") { currentIndex += 1 }
                            .disabled(currentIndex == products.count - 1)
                    }
                }
            } else {
                Text("No products")
            }
        }
    }
}
