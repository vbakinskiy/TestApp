//
//  CoreDataManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import Foundation
import CoreData

enum Action {
    case write
    case owerwrite
    case error
}

class CoreDataManager {
    
    //MARK: - Private properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    //MARK: - Private funcs
    
    private func getAction(for product: Product) -> Action {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            
            if objects.first(where: { $0.productId == product.productId }) != nil {
                return Action.owerwrite
            } else {
                return Action.write
            }
        } catch {
            print(error.localizedDescription)
            return Action.error
        }
    }
    
    private func createEntity(from product: Product) {
        let productEntity = ProductEntity(context: context)
        productEntity.productId = product.productId
        productEntity.imageUrl = product.image
        productEntity.name = product.name
        productEntity.price = String(product.price ?? 0)
        productEntity.descript = product.description
    }
    
    private func overwriteEntity(with product: Product) {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            if let object = objects.first(where: { $0.productId == product.productId }) {
                if product.description != nil {
                    object.setValue(product.description, forKey: "descript")
                }
                object.setValue(product.name, forKey: "name")
                object.setValue(String(product.price ?? 0), forKey: "price")
                object.setValue(product.image, forKey: "imageUrl")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Public funcs
    
    public func save(_ product: Product?) {
        guard let product = product else { return }
        
        switch getAction(for: product) {
        case .write:
            createEntity(from: product)
        case .owerwrite:
            overwriteEntity(with: product)
        case .error:
            break
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getProducts() -> [Product]? {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            let productEntities = try context.fetch(fetchRequest)
            var products: [Product] = []
            
            for entity in productEntities {
                let product = Product(productId: entity.productId,
                                      image: entity.imageUrl,
                                      name: entity.name,
                                      price: Int(entity.price ?? ""),
                                      description: entity.descript)
                products.append(product)
            }
            
            return products
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}