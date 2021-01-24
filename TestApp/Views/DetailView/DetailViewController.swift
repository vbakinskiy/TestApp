//
//  DetailsViewController.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Public properties
    
    var detailsViewViewModel: DetailViewViewModel?
    
    //MARK: - @IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        getProduct()
    }
    
    //MARK: - Private funcs
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        imageView.isHidden = true
        nameLabel.isHidden = true
        descriptionLabel.isHidden = true
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        imageView.isHidden = false
        nameLabel.isHidden = false
        descriptionLabel.isHidden = false
    }
    
    private func getProduct() {
        showActivityIndicator()
        detailsViewViewModel?.getProductDetail {
            DispatchQueue.main.async {
                self.setupView()
                self.hideActivityIndicator()
            }
        }
    }
    
    private func setupView() {
        nameLabel.text = detailsViewViewModel?.name
        descriptionLabel.text = detailsViewViewModel?.description
        imageView.fetchImage(with: detailsViewViewModel?.imageUrl) {}
    }
}
