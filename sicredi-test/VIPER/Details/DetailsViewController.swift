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
        mainStackView.spacing = 20
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setContentLayout() {
        mainStackView.addArrangedSubview(titleLabel)
        titleLabel.font = titleLabel.font.withSize(28)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(34)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(dateLabel)
        dateLabel.font = dateLabel.font.withSize(20)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.textAlignment = .center
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(32)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(priceLabel)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.textAlignment = .center
        priceLabel.backgroundColor = .red
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.height.equalTo(23)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(eventImage)
        eventImage.contentMode = .scaleAspectFill
        eventImage.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.height.equalTo(200)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(descriptionTextView)
        descriptionTextView.adjustsFontForContentSizeCategory = true
        descriptionTextView.font = descriptionTextView.font?.withSize(14)
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(eventImage.snp.bottom)
            $0.height.equalTo(140)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(20)
            $0.height.equalTo(180)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(checkinButton)
        checkinButton.addTarget(self, action: #selector(getUserInfo), for: .touchUpInside)
        checkinButton.backgroundColor = .blue
        checkinButton.layer.cornerRadius = 10
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
        dateLabel.text = convertDate(event: presenter?.event?.date ?? 0)
        if let price = presenter?.event?.price {
            priceLabel.text = "\(price)"
        }
        let url = URL(string: presenter?.event!.image ?? "")
        eventImage.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        descriptionTextView.text = presenter?.event?.description
        
    }
    
}
