//
//  ProductCell.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    //MARK: - Public properties
    
    static let reuseId = "ProductCell"
    
    //MARK: - @IBOutlets
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
}
