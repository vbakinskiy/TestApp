//
//  CellViewModelType.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/24/21.
//

import Foundation

protocol CellViewModelType {
    var imageUrl: String? { get }
    var name: String? { get }
    var price: String? {get}
}
