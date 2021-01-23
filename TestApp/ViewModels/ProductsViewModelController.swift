//
//  ProductsViewModelController.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import Foundation

class ProductsViewModelController {
    
    //MARK: - Public properties
    
    public var productsCount: Int {
        productViewModels.count
    }
    
    //MARK: - Private properties
    
    private let coreDataManager = CoreDataManager()
    private var productViewModels: [ProductViewModel] = []
    private let url = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
    
    //MARK: - Public funcs
    
    public func product(at index: Int) -> ProductViewModel {
        productViewModels[index]
    }
    
    public func getProductViewModels(completion: @escaping () -> ()) {
        if ReachabilityManager.isNetworkAvailable {
            NetworkManager.decodeJson(url: url) { (json: Json?) in
                guard let products = json else { return }
                for product in products.products {
                    let productViewModel = ProductViewModel(productId: product.productId,
                                                            imageUrl: product.image,
                                                            name: product.name,
                                                            price: product.price,
                                                            description: nil)
                    self.coreDataManager.save(productViewModel)
                    self.productViewModels.append(productViewModel)
                }
                completion()
            }
        } else {
            guard let products = coreDataManager.getProducts() else { return }
            productViewModels = products
        }
    }
}
