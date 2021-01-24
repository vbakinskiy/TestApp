//
//  DetailViewViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import Foundation

class DetailViewViewModel {
    
    //MARK: - Private properties
    
    private var product: Product?
    private var productDetail: Product?
    
    //MARK: - Public properties
    
    var imageUrl: String? {
        productDetail?.image
    }
    
    var name: String? {
        productDetail?.name
    }
    
    var description: String? {
        productDetail?.description
    }
    
    //MARK: - Init
    
    init(product: Product?) {
        self.product = product
    }
    
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
    
    public func getProductDetail(completion: @escaping () -> ()) {
        if NetworkManager.isNetworkAvailable {
            NetworkManager.decodeJson(url: url) { (product: Product?) in
                guard let product = product else { return }
                self.productDetail = product
                self.coreDataManager.save(product)
                completion()
            }
        } else {
            guard let products = coreDataManager.getProducts() else { return }
            
            if let product = products.first(where: { $0.productId == product?.productId }) {
                productDetail = product
                completion()
            }
        }
    }
}
