//
//  AlertManager.swift
//  TestApp
//
//  Created by Vyacheslav Bakinskiy on 1/24/21.
//

import UIKit

class AlertManager {
    static func showErrorMessage(_ viewController: UIViewController?, _ error: Error) {
        guard let viewController = viewController else { return }
        let alert = UIAlertController(title: "Error",
                                      message: "\(error.localizedDescription). Try again",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: UIAlertAction.Style.default,
                                     handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
