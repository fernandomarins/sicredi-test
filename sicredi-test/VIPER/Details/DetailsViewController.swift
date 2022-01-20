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

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }

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
        mainStackView.alignment = .top
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
            $0.top.equalTo(dateLabel.snp.bottom).offset(15)
            $0.height.equalTo(23)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(eventImage)
        eventImage.contentMode = .scaleAspectFill
        eventImage.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(60)
            $0.height.equalTo(240)
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
            $0.height.equalTo(180)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        mainStackView.addArrangedSubview(checkinButton)
        
        
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
