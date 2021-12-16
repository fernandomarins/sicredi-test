//
//  Extensions+UIViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, titleAction: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: titleAction, style: .default, handler: nil)
        alert.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
