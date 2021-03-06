//
//  CollectionViewController.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class CollectionViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var viewModel: CollectionViewViewModelType?
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
        setupViewModel()
        getProducts()
    }
    
    //MARK: - Private funcs
    
    private func registerCell() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.reuseId)
    }
    
    private func setupCollectionViewLoyout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing,
                                           bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupViewModel() {
        viewModel = CollectionViewViewModel()
    }
    
    private func getProducts() {
        activityIndicator.startAnimating()
        viewModel?.getProducts { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    AlertManager.showErrorMessage(self, error)
                }
                
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func showDetails(for indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailView") as? DetailsViewController {
            vc.detailViewViewModel = viewModel?.detailViewModel(for: indexPath)
            present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Interface orientation
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation,
                             duration: TimeInterval) {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId,
                                                      for: indexPath) as? CollectionViewCell
        guard let collectionViewCell = cell else { return UICollectionViewCell() }
        collectionViewCell.cellViewModel = viewModel?.cellViewModel(for: indexPath)
        
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacing)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(for: indexPath)
    }
}

