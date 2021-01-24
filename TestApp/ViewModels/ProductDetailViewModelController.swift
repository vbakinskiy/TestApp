//
//  DetailsViewViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import Foundation

class DetailsViewViewModel {
    
    //MARK: - Public properties
    
    public var product: ProductDetails?
    
    //MARK: - Private properties
    
    private let coreDataManager = CoreDataManager()
    
    private var url: String {
        if let productId = product?.productId {
            return "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(productId)/detail"
        } else {
            return ""
        }
    }
    
    //MARK: - Public funcs
    
    public func getProductViewModel(completion: @escaping (ProductDetails?) -> ()) {
        if ReachabilityManager.isNetworkAvailable {
            NetworkManager.decodeJson(url: url) { (product: ProductDetails?) in
                guard let product = product else { return }
//                let productViewModel = CellViewModel(productId: product.productId,
//                                                        imageUrl: product.image,
//                                                        name: product.name,
//                                                        price: product.price,
//                                                        description: product.description)
//                self.coreDataManager.save(productViewModel)
                completion(product)
            }
        } else {
            guard let products = coreDataManager.getProducts() else { return }
            
            if let product = products.first(where: { $0.productId == product?.productId }) {
                completion(product)
            }
        }
    }
}
