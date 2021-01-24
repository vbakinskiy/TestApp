//
//  UIImage + Extension.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

extension UIImageView {
    func fetchImage(with url: String?, completion: @escaping () -> ()) {
        guard let url = url, let imageUrl = URL(string: url) else { return }
        let fileName = imageUrl.lastPathComponent
        
        if let cachedImage  = CacheManager.getCachedImage(withName: fileName) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion()
            }
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.image = nil
                    completion()
                }
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                    CacheManager.saveImageToCache(data: data, withName: fileName)
                    completion()
                }
            }
        }.resume()
    }
}
