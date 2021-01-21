//
//  NetworkManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class NetworkManager {
    private static func getJson(completion: @escaping (Products?) -> ()) {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Can't fetch data")
                return completion(nil)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let json = try? decoder.decode(Products.self, from: data) {
                completion(json)
            } else {
                print("Can't decode json")
                completion(nil)
            }
        }.resume()
    }
    
    static func parseJson(completion: @escaping ([ProductViewModel]?) -> ()) {
        var productViewModels: [ProductViewModel] = []
        getJson { products in
            guard let products = products?.products else { return }
            for product in products {
                let product = ProductViewModel(productImage: product.image, productName: product.name, productPrice: product.price)
                productViewModels.append(product)
            }
            completion(productViewModels)
        }
    }
}

