//
//  CollectionViewViewModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import Foundation

class CollectionViewViewModel: CollectionViewViewModelType {
    
    //MARK: - Private properties
    
    private let coreDataManager = CoreDataManager()
    private var products: [Product] = []
    private let url = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
    
    //MARK: - Public funcs
    
    public func numberOfRows() -> Int {
        products.count
    }
    
    public func cellViewModel(for indexPath: IndexPath) -> CellViewModelType {
        CellViewModel(product: products[indexPath.row])
    }
    
    public func detailViewModel(for indexPath: IndexPath) -> DetailViewViewModelType {
        DetailViewViewModel(product: products[indexPath.row])
    }
    
    public func getProducts(completion: @escaping (Error?) -> ()) {
        if NetworkManager.isNetworkAvailable {
            NetworkManager.decodeJson(from: url) { [weak self] (json: Json?, error) in
                if let error = error {
                    completion(error)
                    return
                }
                
                if let json = json {
                    for product in json.products {
                        self?.products.append(product)
                        self?.coreDataManager.save(product) { error in
                            if let error = error {
                                completion(error)
                                return
                            }
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
                
                if let products = products {
                    self?.products = products
                    completion(nil)
                }
            }
        }
    }
}
