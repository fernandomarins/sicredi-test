//
//  DetailsViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var event: Event?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: event!.image)
        
        Client.downloadImage(from: url!) { data, error in
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription, titleAction: "OK")
                return
            }
            
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                self.image.image = UIImage(data: data)
                if self.image.image == nil {
                    self.image.image = UIImage(named: "placeholder")
                }
            }
        }
        
        let dateTime = event!.date/1000
        let timeInterval = Double(dateTime)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, d MMM, yyyy"
        
        let date = df.string(from: myDate)
        dateLabel.text = date
        titleLabel.text = event?.title
        priceLabel.text = "R$ " + event!.price.description
        descriptionTextView.text = event?.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
