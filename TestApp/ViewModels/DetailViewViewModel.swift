//
//  DetailViewViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import Foundation

class DetailViewViewModel: DetailViewViewModelType {
    
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
    
    //MARK: - Public funcs
    
    public func getProductDetail(completion: @escaping (Error?) -> ()) {
        if NetworkManager.isNetworkAvailable {
            NetworkManager.decodeJson(from: API.productURL(product)) {
                [weak self] (product: Product?, error)  in
                if let error = error {
                    completion(error)
                    return
                }
                
                if let product = product {
                    self?.productDetail = product
                    CoreDataManager.save(product) { error in
                        if let error = error {
                            completion(error)
                            return
                        }
                    }
                    completion(nil)
                }
            }
        } else {
            CoreDataManager.getProducts { [weak self] products, error in
                if let error = error {
                    completion(error)
                    return
                }
                
                if let product = products?
                    .first(where: { $0.productId == self?.product?.productId }) {
                    self?.productDetail = product
                    completion(nil)
                }
            }
        }
    }
}
