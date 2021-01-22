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
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }
    
    //MARK: - Private funcs
    
    private func setupCell() {
        imageView.fetchImage(with: cellModel?.imageUrl)
        nameLabel.text = cellModel?.name
        priceLabel.text = "$\(cellModel?.price ?? 0)"
    }
}
