//
//  CollectionViewViewModelType.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/24/21.
//

import Foundation

protocol CollectionViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(for indexPath: IndexPath) -> CellViewModelType
    func detailViewModel(for indexPath: IndexPath) -> DetailViewViewModelType
    func getProducts(completion: @escaping (Error?) -> ())
}
