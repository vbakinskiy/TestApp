//
//  JsonModel.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let productId: String?
    let image: String?
    let name: String?
    let price: Int?
    let description: String?
}
