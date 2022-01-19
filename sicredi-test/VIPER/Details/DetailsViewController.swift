//
//  DetailsViewController.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit
import MapKit
import SnapKit

class DetailsViewController: UIViewController, DetailsViewContract {

    var presenter: DetailsPresenterContract?
    
    // MARK: ViewCode
    
    private let mainScrollView = UIScrollView()
    private let mainContainer = UIView()
    private let mainStackView = UIStackView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let priceLabel = UILabel()
    private let image = UIImageView()
    private let descriptionTextView = UITextView()
    private let mapView = MKMapView()
    private let checkinButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        print("oi")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    private func setLayout() {
        setScrollLayoutView()
        setContentLayout()
    }
    
    private func setScrollLayoutView() {
        view.addSubview(mainScrollView)
    }
    
    private func setContentLayout() {
        
    }

}
