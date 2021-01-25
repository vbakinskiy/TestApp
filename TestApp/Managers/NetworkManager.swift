//
//  NetworkManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/21/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //MARK: - Public properties
    
    static var isNetworkAvailable: Bool {
        NetworkReachabilityManager()!.isReachable
    }
    
    //MARK: - Public funcs
    
    static func decodeJson<T: Codable>(from url: String?, completion: @escaping (T?, Error?) -> ()) {
        guard let urlString = url, let url = URL(string: urlString) else {
            let error: Error = CustomError.urlError
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let json = try decoder.decode(T.self, from: data)
                    completion(json, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
