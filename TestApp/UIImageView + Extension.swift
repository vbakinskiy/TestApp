//
//  UIImage + Extension.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

extension UIImageView {
    func fetchImage(with url: String?) {
        guard let url = url, let imageUrl = URL(string: url) else { return }
        let fileName = imageUrl.lastPathComponent
        
        if let cachedImage  = CacheManager.getCachedImage(withName: fileName) {
            image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [unowned self] data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    CacheManager.saveImageToCache(data: data, withName: fileName)
                }
            }
        }.resume()
    }
}