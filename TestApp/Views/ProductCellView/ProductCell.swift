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
    
    var cellModel: ProductViewModel? {
        didSet {
            setupCell()
        }
    }
    
    //MARK: - @IBOutlets
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.contentMode = .scaleAspectFill
    }
    
    //MARK: - Private funcs
    
    private func setupCell() {
        productImageView.fetchImage(with: cellModel?.productImage)
        productNameLabel.text = cellModel?.productName
        productPriceLabel.text = "$\(cellModel?.productPrice ?? 0)"
    }
}
