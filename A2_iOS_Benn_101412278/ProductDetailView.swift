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
        if let product = product {
            VStack() {
                Form {
                    Section(header: Text(product.productName ?? "Product name placeholder")
                        .font(.system(size: 24, weight: .bold))
                    ) {
                        LabeledContent("Description", value: product.productDescription ?? "Product description placeholder")
                        LabeledContent("Price", value: String(format: "$%.2f", product.productPrice))
                        LabeledContent("Provider", value: product.productProvider ?? "Product provider placeholder")
                    }
                    
                    Section {
                        HStack {
                            Button("Previous") { currentIndex -= 1 }
                                .disabled(currentIndex == 0)
                            Spacer()
                            Text("\(currentIndex + 1)/\(products.count)")
                            Spacer()
                            Button("Next") { currentIndex += 1 }
                                .disabled(currentIndex == products.count - 1)
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .navigationTitle("Browse")
            }
            .onAppear {
                if let current = currentProduct, let index = products.firstIndex(of: current) {
                    currentIndex = index
                }
            }
        } else {
            Text("No products")
        }
    }
}
