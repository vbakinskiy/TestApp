//
//  API.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/25/21.
//

import Foundation

struct API {
    static let baseURL = URL("https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list")
    
    static func productURL(_ product: Product?) -> URL? {
        guard let product = product,
              let productId = product.productId else {
            return nil
        }
        var components = URLComponents()
        components.scheme = "https"
        components.host = "s3-eu-west-1.amazonaws.com"
        components.path = "/developer-application-test/cart/\(productId)/detail"
        
        let url = components.url
        return url
    }
}
