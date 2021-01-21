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
        products.count
    }
    
    //MARK: - Private properties
    
    private var products: [ProductViewModel] = []
    
    //MARK: - Public funcs
    
    public func product(at index: Int) -> ProductViewModel {
        products[index]
    }
    
    public func getProducts(completion: @escaping () -> ()) {
        NetworkManager.parseJson { products in
            guard let products = products else { return }
            self.products = products
            completion()
        }
    }
}
