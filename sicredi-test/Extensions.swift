//
//  Extensions.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Displayin alert
    func showAlert(title: String, message: String, titleAction: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: titleAction, style: .default, handler: nil)
        alert.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Convert date from Int to String
    func convertDate(event: Int) -> String {
        let dateTime = event/1000
        let timeInterval = Double(dateTime)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, d MMM, yyyy"
        
        let date = df.string(from: myDate)
        
        return date
    }
}

extension URLResponse {

    // Returning the status code of the HTTP request
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
