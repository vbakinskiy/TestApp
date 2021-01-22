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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProduct()
    }
    
    //MARK: - Private funcs
    
    private func getProduct() {
        productDetailViewModelController.getProductViewDetailModel { product in
            DispatchQueue.main.async {
                self.setupView(with: product)
            }
        }
    }
    
    private func setupView(with product: ProductDetailViewModel?) {
        nameLabel.text = product?.name
        descriptionLabel.text = product?.description
        imageView.contentMode = .scaleAspectFill
        imageView.fetchImage(with: product?.imageUrl)
    }
}
