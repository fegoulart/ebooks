//
//  Alert.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 17/03/21.
//

import UIKit

struct Alert {
    private static func showBasicAlert(on viewController: UIViewController,
                                       with title: String,
                                       message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    static func showUnableToRetrieveDataAlert(on viewController: UIViewController) {
        showBasicAlert(on: viewController,
                       with: "Unable to Retrieve Data",
                       message: "Network Error. Please pull the screen to refresh")
    }
}
