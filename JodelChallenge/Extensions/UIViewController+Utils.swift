//
//  UIViewController+Utils.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 22.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit

extension UIViewController {
    

    /// alert view controller
    ///
    /// - Parameters:
    ///   - title: String
    ///   - contentText: String
    ///   - actions: UIAlertAction
    func showAlert(title: String, contentText: String, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: contentText, preferredStyle: .alert)
            for action in actions {
                alertController.addAction(action)
            }
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
