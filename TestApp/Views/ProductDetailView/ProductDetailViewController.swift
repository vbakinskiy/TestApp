//
//  ProductDetailViewController.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    //MARK: - Public properties
    
    let productDetailViewModelController = ProductDetailViewModelController()
    
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
        productDetailViewModelController.getProductViewModel { product in
            DispatchQueue.main.async {
                self.setupView(with: product)
                self.hideActivityIndicator()
            }
        }
    }
    
    private func setupView(with product: ProductViewModel?) {
        nameLabel.text = product?.name
        descriptionLabel.text = product?.description
        imageView.fetchImage(with: product?.imageUrl) {}
    }
}
