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
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayData()
    }
    
    private func displayData() {
        dateLabel.text = convertDate(event: event!.date)
        titleLabel.text = event?.title
        priceLabel.text = "R$ " + event!.price.description
        descriptionTextView.text = event?.description
        loadImage()
        loadLocation()
    }
    
    private func loadImage() {
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
                self.setPlaceholder(image: self.image)
            }
        }
    }
    
    private func setPlaceholder(image: UIImageView) {
        if image.image == nil {
            image.image = UIImage(named: "placeholder")
        }
    }
    
    private func loadLocation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: event!.latitude, longitude: event!.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let location = CLLocationCoordinate2DMake(event!.latitude, event!.longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        annotation.title = event?.title
        mapView.addAnnotation(annotation)
    }

}

extension DetailsViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = .blue
        }
        else {
            pinView!.annotation = annotation
        }
        
        // It's required to set canShowCallOut to display the button
        pinView?.canShowCallout = true
        
        // Creating the button to open the location in Maps
        let button = UIButton(type: .infoLight)
        pinView?.rightCalloutAccessoryView = button
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: event?.latitude ?? 0.0, longitude: event?.longitude ?? 0.0)))
            MKMapItem.openMaps(with: [source], launchOptions: nil)
        }
    }
}
