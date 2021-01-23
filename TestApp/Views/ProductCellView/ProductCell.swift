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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupActivityIndicator()
    }
    
    //MARK: - Private funcs
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    private func setupCell() {
        showActivityIndicator()
        imageView.fetchImage(with: cellModel?.imageUrl) {
            self.hideActivityIndicator()
        }
        nameLabel.text = cellModel?.name
        priceLabel.text = "$\(cellModel?.price ?? 0)"
    }
}
