//
//  ProductCell.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - Public properties
    
    static let reuseId = "CollectionViewCell"
    
    var cellViewModel: CellViewModel? {
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
        nameLabel.text = cellViewModel?.name
        priceLabel.text = cellViewModel?.price
        imageView.fetchImage(with: cellViewModel?.imageUrl) {
            DispatchQueue.main.async {
                self.hideActivityIndicator()
            }
        }
    }
}
