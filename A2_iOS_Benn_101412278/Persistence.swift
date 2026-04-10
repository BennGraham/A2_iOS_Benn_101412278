//
//  Persistence.swift
//  A2_iOS_Benn_101412278
//
//  Created by Benn Graham on 2026-03-29.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let product = Product(context: viewContext)
            product.productId = UUID()
            product.productName = "Product \(i)"
            product.productDescription = "Description for product \(i). This is the description for product \(i)."
            product.productPrice = Double.random(in: 0.99...9.99)
            product.productProvider = "Provider \(i)"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Benn_101412278")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        if !UserDefaults.standard.bool(forKey: "hasSeededProducts") {
            seedProducts(context: container.viewContext)
            UserDefaults.standard.set(true, forKey: "hasSeededProducts")
        }
    }
    
    private func seedProducts(context: NSManagedObjectContext) {
        let products: [(String, String, Double, String)] = [
            ("Product 1", "Product 1 Description", 9.99, "Product 1 Provider"),
            ("Product 2", "Product 2 Description", 12.99, "Product 2 Provider"),
            ("Product 3", "Product 3 Description", 1.99, "Product 3 Provider"),
            ("Product 4", "Product 4 Description", 24.99, "Product 4 Provider"),
            ("Product 5", "Product 5 Description", 112.99, "Product 5 Provider"),
            ("Product 6", "Product 6 Description", 92.99, "Product 6 Provider"),
            ("Product 7", "Product 7 Description", 52.99, "Product 7 Provider"),
            ("Product 8", "Product 8 Description", 22.50, "Product 8 Provider"),
            ("Product 9", "Product 9 Description", 56.99, "Product 9 Provider"),
            ("Product 10", "Product 10 Description", 1900.76, "Product 10 Provider")
        ]
        
        for (name, desc, price, provider) in products {
            let product = Product(context: context)
            product.productId = UUID()
            product.productName = name
            product.productDescription = desc
            product.productPrice = price
            product.productProvider = provider
        }
        
        // pattern fromt he default save and delete functions in contentview to save data
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        
    }
}
