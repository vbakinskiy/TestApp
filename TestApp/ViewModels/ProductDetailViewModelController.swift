//
//  ProductDetailViewModelController.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import Foundation

class ProductDetailViewModelController {
    
    //MARK: - Public properties
    
    public var product: ProductViewModel?
    
    //MARK: - Private properties
    
    private var url: String {
        if let productId = product?.productId {
            return "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(productId)/detail"
        } else {
            return ""
        }
    }
    
    //MARK: - Public funcs
    
    public func getProductViewDetailModel(completion: @escaping (ProductDetailViewModel?) -> ()) {
        NetworkManager.decodeJson(url: url) { (product: Product?) in
            guard let product = product else { return }
            let productDetailViewModel = ProductDetailViewModel(productId: product.productId,
                                                                imageUrl: product.image,
                                                                name: product.name,
                                                                price: product.price,
                                                                description: product.description)
            completion(productDetailViewModel)
        }
    }
}
