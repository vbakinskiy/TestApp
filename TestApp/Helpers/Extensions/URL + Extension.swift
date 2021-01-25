//
//  URL + Extension.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/25/21.
//

import Foundation

extension URL {
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }
}
