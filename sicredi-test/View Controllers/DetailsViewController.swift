//
//  DetailsViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    // MARK: - Variables/Constants
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var event: Event?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if event != nil {
            displayData()
        }
    }
    
    // MARK: - Private methods
    
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
        // Zooming in
        mapView.setRegion(region, animated: true)
        annotation.title = event?.title
        // Adding the pin
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - Actions
    
    @IBAction func checkinAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Check in", message: "Adicione suas informações", preferredStyle: .alert)
        // Creating the text fields
        alert.addTextField { textfield in
            textfield.placeholder = "Digite seu nome..."
        }
        
        alert.addTextField { textfield in
            textfield.placeholder = "Digite seu e-mail..."
        }
        
        alert.addAction(UIAlertAction(title: "Check-in", style: .default, handler: { _ in
            if let name = alert.textFields![0].text,
               let email = alert.textFields![1].text,
               let event = self.event {
                Client.checkIn(eventId: event.id, name: name, email: email) { data, response, error in
                    guard response?.getStatusCode() == 200 else {
                        self.showAlert(title: "Woops!", message: "Não foi possível realizar o check-in!", titleAction: "OK")
                        return
                    }
                    
                    self.showAlert(title: "Perfeito!", message: "Check-in confirmado!", titleAction: "OK")
                }
            }
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        if let event = event {
            let message = "Olha esse evento incrível que eu vou!"
            let urlString = Client.Endpoints.baseURL + Client.Endpoints.events + "\(event.id)"
            let url = URL(string: urlString)
            
            let objectsToShare = [message, url as Any]
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
    }
    
    
}

extension DetailsViewController: MKMapViewDelegate {
    
    // Making the annotations become pins instead of bubbles
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
            // Opening the location in Maps
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: event?.latitude ?? 0.0, longitude: event?.longitude ?? 0.0)))
            MKMapItem.openMaps(with: [source], launchOptions: nil)
        }
    }
}
