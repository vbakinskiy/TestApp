//
//  DetailViewViewModelType.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/24/21.
//

import Foundation

protocol DetailViewViewModelType {
    var imageUrl: String? { get }
    var name: String? { get }
    var description: String? { get }
    func getProductDetail(completion: @escaping (Error?) -> ())
}
