//
//  ProductDetailView.swift
//  A2_iOS_Benn_101412278
//
//  Created by Benn Graham on 2026-04-05.
//

import SwiftUI
import CoreData

struct ProductDetailView:  View {
    let product: Product
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            VStack {
                Text(product.productName ?? "Product Name Placeholder")
                Text(product.productDescription ?? "Product Description Placeholder")
                Text(String(product.productPrice))
                Text(product.productProvider ?? "Product Provider Placeholder")
            }
            .navigationTitle("Product Details")
        }
    }
}
