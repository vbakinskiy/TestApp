//
//  ProductViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import Foundation

class CellViewModel {
    private var product: Product
    
    var productId: String? {
        product.productId
    }
    
    var imageUrl: String? {
        product.image
    }
    
    var name: String? {
        product.name
    }
    
    var price: String? {
        "$\(product.price ?? 0)"
    }
    
    init(product: Product) {
        self.product = product
    }
}
