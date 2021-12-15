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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
