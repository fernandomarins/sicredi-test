//
//  DetailsViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit
import MapKit
import SnapKit
import Kingfisher

class DetailsViewController: UIViewController, DetailsViewContract {
    
    
    var presenter: DetailsPresenterContract?
    
    // MARK: ViewCode
    
    private let mainScrollView = UIScrollView()
    private let mainContainer = UIView()
    private let mainStackView = UIStackView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let priceLabel = UILabel()
    private let eventImage = UIImageView()
    private let descriptionTextView = UITextView()
    private let mapView = MKMapView()
    private let checkinButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    private func setLayout() {
        setScrollLayoutView()
        setContentLayout()
        setContent()
        loadLocation()
        
        mapView.delegate = self
    }
    
    private func setScrollLayoutView() {
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        mainScrollView.addSubview(mainContainer)
        mainContainer.backgroundColor = .white
        mainContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.medium)
        }
        
        mainContainer.addSubview(mainStackView)
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 30
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setContentLayout() {
        mainStackView.addArrangedSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(70)
            $0.leading.equalTo(mainStackView.snp.leading).offset(5)
            $0.trailing.equalTo(mainStackView.snp.trailing).offset(-5)
        }
        
        mainStackView.addArrangedSubview(dateLabel)
        dateLabel.font = dateLabel.font.withSize(20)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.textAlignment = .center
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(23)
            $0.leading.equalTo(mainStackView.snp.leading).offset(15)
            $0.trailing.equalTo(mainStackView.snp.trailing).offset(-15)
        }
        
        mainStackView.addArrangedSubview(priceLabel)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.textAlignment = .center
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.height.equalTo(23)
            $0.leading.equalTo(mainStackView.snp.leading).offset(15)
            $0.trailing.equalTo(mainStackView.snp.trailing).offset(-15)
        }
        
        mainStackView.addArrangedSubview(eventImage)
        eventImage.contentMode = .scaleToFill
        eventImage.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.height.equalTo(240)
            $0.leading.equalTo(mainStackView.snp.leading).offset(15)
            $0.trailing.equalTo(mainStackView.snp.trailing).offset(-15)
        }
        
        mainStackView.addArrangedSubview(descriptionTextView)
        descriptionTextView.adjustsFontForContentSizeCategory = true
        descriptionTextView.sizeToFit()
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(eventImage.snp.bottom).offset(20)
            $0.height.equalTo(140)
            // I am setting to 12 because the textview has a little padding, apparently
            $0.leading.equalTo(mainStackView.snp.leading).offset(15)
            $0.trailing.equalTo(mainStackView.snp.trailing).offset(-15)
        }
        
        mainStackView.addArrangedSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(20)
            $0.height.equalTo(180)
            $0.leading.equalTo(mainStackView.snp.leading).offset(15)
            $0.trailing.equalTo(mainStackView.snp.trailing).offset(-15)
        }
        
        mainStackView.addArrangedSubview(checkinButton)
        checkinButton.addTarget(self, action: #selector(getUserInfo), for: .touchUpInside)
        checkinButton.backgroundColor = .blue
        checkinButton.layer.cornerRadius = 8
        checkinButton.setTitle("Check-in", for: .normal)
        checkinButton.setTitleColor(.white, for: .normal)
        checkinButton.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(20)
            $0.height.equalTo(32)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
    @objc func getUserInfo() {
        let alert = UIAlertController(title: "Check in", message: "Adicione suas informações", preferredStyle: .alert)
        // Creating the text fields to check-in
        alert.addTextField { textfield in
            textfield.placeholder = "Digite seu nome..."
        }
        
        alert.addTextField { textfield in
            textfield.placeholder = "Digite seu e-mail..."
        }
        
        alert.addAction(UIAlertAction(title: "Check-in", style: .default, handler: { [weak self] _ in
            if let name = alert.textFields![0].text,
               let email = alert.textFields![1].text {
                self?.presenter?.performCheckIn(name: name, email: email)
                
            }
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkInDone() {
        showAlert(title: "Perfeito!", message: "Check-in confirmado!", titleAction: "OK")
    }
    
    func showError() {
        showAlert(title: "Woops!", message: "Não foi possível realizar o check-in!", titleAction: "OK")
    }
    
    private func setContent() {
        titleLabel.text = presenter?.event?.title
        dateLabel.text = presenter?.event?.date.convertIntDateToString() ?? ""
        if let price = presenter?.event?.price {
            priceLabel.text = "R$ \(price)"
        }
        let url = URL(string: presenter?.event!.image ?? "")
        eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, completionHandler: nil)
        descriptionTextView.text = presenter?.event?.description
    }
        
    private func loadLocation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: presenter?.event?.latitude ?? 0.0, longitude: presenter?.event?.longitude ?? 0.0)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let location = CLLocationCoordinate2DMake(presenter?.event?.latitude ?? 0.0, presenter?.event?.longitude ?? 0.0)
        let region = MKCoordinateRegion(center: location, span: span)
        // Zooming in
        mapView.setRegion(region, animated: true)
        annotation.title = presenter?.event?.title
        // Adding the pin
        mapView.addAnnotation(annotation)
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
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: presenter?.event?.latitude ?? 0.0, longitude: presenter?.event?.longitude ?? 0.0)))
            MKMapItem.openMaps(with: [source], launchOptions: nil)
        }
    }
}
