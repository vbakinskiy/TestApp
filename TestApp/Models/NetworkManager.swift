//
//  NetworkManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class NetworkManager {
    static func getProducts(completion: @escaping (Products?) -> ()) {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Can't fetch data")
                return completion(nil)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let products = try? decoder.decode(Products.self, from: data) {
                completion(products)
            } else {
                print("Can't decode json")
                completion(nil)
            }
        }.resume()
    }
}

