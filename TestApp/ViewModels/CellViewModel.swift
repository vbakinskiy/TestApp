//
//  ProductViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import Foundation

class CellViewModel: CellViewModelType {
    
    //MARK: - Private properties
    
    private var product: Product
    
    //MARK: - Public properties
    
    var imageUrl: String? {
        product.image
    }
    
    var name: String? {
        product.name
    }
    
    var price: String? {
        "$\(product.price ?? 0)"
    }
    
    //MARK: - Init
    
    init(product: Product) {
        self.product = product
    }
}
