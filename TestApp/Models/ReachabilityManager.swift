//
//  ReachabilityManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//

import Foundation
import Alamofire

struct ReachabilityManager {
    static var isNetworkAvailable: Bool {
        NetworkReachabilityManager()!.isReachable
    }
}
