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
    
    var cellViewModel: CellViewModelType? {
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
        activityIndicator.hidesWhenStopped = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.contentMode = .scaleAspectFill
        imageView.image = nil
    }
    
    //MARK: - Private funcs
    
    private func setupCell() {
        activityIndicator.startAnimating()
        nameLabel.text = cellViewModel?.name
        priceLabel.text = cellViewModel?.price
        imageView.fetchImage(from: cellViewModel?.imageUrl) {
            self.activityIndicator.stopAnimating()
        }
    }
}
