//
//  CollectionViewController.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class CollectionViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let collectionViewViewModel = CollectionViewViewModel()
    
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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupCollectionViewLoyout()
        setupActivityIndicator()
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
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    private func getProducts() {
        showActivityIndicator()
        collectionViewViewModel.getProductViewModels {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.hideActivityIndicator()
            }
        }
    }
    
    private func showDetails(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailsView", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailsView") as? DetailsViewController {
            vc.detailsViewViewModel = collectionViewViewModel.detailViewModel(for: indexPath)
            present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Interface orientation
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewViewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        
        cell.cellViewModel = collectionViewViewModel.cellViewModel(for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacing)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(indexPath: indexPath)
    }
}

