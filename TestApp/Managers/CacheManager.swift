//
//  FileManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit

class CacheManager {
    
    //MARK: - Private properties
    
    private static let directoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    //MARK: - Public funcs
    
    static func getCachedImage(withName: String) -> UIImage? {
        let fileURL = directoryURL.appendingPathComponent(withName)
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
    
    static func saveImageToCache(data: Data, withName: String) {
        let fileURL = directoryURL.appendingPathComponent(withName)
        do {
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
