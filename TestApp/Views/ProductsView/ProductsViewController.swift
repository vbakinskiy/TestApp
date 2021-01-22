//
//  ProductsViewController.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class ProductsViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let productsViewModelController = ProductsViewModelController()
    
    private var numberOfItemsPerRow: CGFloat {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            return 2
        case .landscapeLeft, .landscapeRight:
            return 4
        default:
            return 2
        }
    }
    
    private let spacing: CGFloat = 16
    
    //MARK: - @IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupCollectionViewLoyout()
        getProducts()
    }
    
    //MARK: - Private funcs
    
    private func registerCell() {
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: ProductCell.reuseId)
    }
    
    private func setupCollectionViewLoyout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
    }
    
    private func getProducts() {
        productsViewModelController.getProductViewModels {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func showDetails(index: Int) {
        let storyboard = UIStoryboard(name: "ProductDetailView", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailView") as? ProductDetailViewController {
            vc.productDetailViewModelController.product = productsViewModelController.product(at: index)
            present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Interface orientation
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsViewModelController.productsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        
        cell.cellModel = productsViewModelController.product(at: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacing)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(index: indexPath.row)
    }
}

