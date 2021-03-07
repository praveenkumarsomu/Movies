//
//  UiViewController+Extension.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

extension UIViewController {
    /// Show error message
    /// - Parameters:
    ///   - title: Alert Title
    ///   - description: error description
    ///   - actions: Buttons show show alert
    func showErrorMessage(with title: String, description: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        actions.forEach { alertAction in
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    /// Create default `OK`
    func defaultAlertButton() -> [UIAlertAction] {
        [UIAlertAction(title: "Ok", style: .default, handler: nil)]
    }
}

