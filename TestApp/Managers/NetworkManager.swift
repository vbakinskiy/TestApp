//
//  NetworkManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import UIKit
import Alamofire

class NetworkManager {
    
    //MARK: - Public properties
    
    static var isNetworkAvailable: Bool {
        NetworkReachabilityManager()!.isReachable
    }
    
    //MARK: - Public funcs
    
    static func decodeJson<T: Codable>(url: String, completion: @escaping (T?) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Can't fetch data")
                return completion(nil)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            if let json = try? decoder.decode(T.self, from: data) {
                completion(json)
            } else {
                print("Can't decode json")
                completion(nil)
            }
        }.resume()
    }
}

