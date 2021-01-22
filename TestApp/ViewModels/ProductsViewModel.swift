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
    
    private var productViewModels: [ProductViewModel] = []
    
    //MARK: - Public funcs
    
    public func product(at index: Int) -> ProductViewModel {
        productViewModels[index]
    }
    
    public func getProductViewModels(completion: @escaping () -> ()) {
        NetworkManager.getProducts { products in
            guard let products = products?.products else { return }
            for product in products {
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
