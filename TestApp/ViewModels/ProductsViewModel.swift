//
//  ProductsViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import Foundation

class ProductsViewModel {
    
    //MARK: - Public properties
    
    public var productsCount: Int {
        productViewModels.count
    }
    
    //MARK: - Private properties
    
    private let url = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
    private var productViewModels: [ProductViewModel] = []
    
    //MARK: - Public funcs
    
    public func product(at index: Int) -> ProductViewModel {
        productViewModels[index]
    }
    
    public func getProductViewModels(completion: @escaping () -> ()) {
        NetworkManager.decodeJson(url: url) { (json: Json?) in
            guard let products = json else { return }
            for product in products.products {
                let product = ProductViewModel(productId: nil,
                                               imageUrl: product.image,
                                               name: product.name,
                                               price: product.price,
                                               description: nil)
                self.productViewModels.append(product)
            }
            completion()
        }
    }
}
