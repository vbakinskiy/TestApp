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
    
    private var productViewModels: [ProductViewModel] = []
    private let url = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
    
    //MARK: - Public funcs
    
    public func product(at index: Int) -> ProductViewModel {
        productViewModels[index]
    }
    
    public func getProductViewModels(completion: @escaping () -> ()) {
        NetworkManager.decodeJson(url: url) { (json: Json?) in
            guard let products = json else { return }
            for product in products.products {
                let product = ProductViewModel(productId: product.productId,
                                               imageUrl: product.image,
                                               name: product.name,
                                               price: product.price)
                self.productViewModels.append(product)
            }
            completion()
        }
    }
}
