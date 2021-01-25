//
//  DetailViewViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import Foundation

class DetailViewViewModel: DetailViewViewModelType {
    
    //MARK: - Private properties
    
    private let coreDataManager = CoreDataManager()
    private var product: Product?
    private var productDetail: Product?
    
    private var productUrl: String? {
        guard let productId = product?.productId else { return nil }
        return "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(productId)/detail"
    }
    
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
    
    //MARK: - Public funcs
    
    public func getProductDetail(completion: @escaping (Error?) -> ()) {
        if NetworkManager.isNetworkAvailable {
            NetworkManager.decodeJson(from: productUrl) { [weak self] (product: Product?, error)  in
                if let error = error {
                    completion(error)
                    return
                }
                
                if let product = product {
                    self?.productDetail = product
                    self?.coreDataManager.save(product) { error in
                        if let error = error {
                            completion(error)
                            return
                        }
                    }
                    completion(nil)
                }
            }
        } else {
            coreDataManager.getProducts { [weak self] products, error in
                if let error = error {
                    completion(error)
                    return
                }
                
                if let product = products?.first(where: { $0.productId == self?.product?.productId }) {
                    self?.productDetail = product
                    completion(nil)
                }
            }
        }
    }
}
