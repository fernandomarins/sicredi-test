//
//  DetailsTests.swift
//  sicredi-testTests
//
//  Created by Fernando Marins on 24/01/22.
//

import XCTest

@testable import sicredi_test
import MapKit

class DetailsTests: XCTestCase {

    func test_canInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_initialState() throws {
        
        let sut = try makeSUT()
        XCTAssertNotNil(sut.presenter?.event)
    }
    
    func test_viewConformsToMKMapViewDelegate() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssert(sut.conforms(to: MKMapViewDelegate.self), "ViewController under test does not conform to MKMapViewDelegate protocol")
    }
    
    func test_isInfoBeingDisplayed() throws {
        
        let sut = try makeSUT()
        
        XCTAssertEqual(sut.presenter?.event?.id, "1")
        XCTAssertEqual(sut.presenter?.event?.description, "Test 1")
        XCTAssertEqual(sut.presenter?.event?.longitude, -51.2146267)
        XCTAssertEqual(sut.presenter?.event?.latitude, -30.0392981)
        XCTAssertEqual(sut.presenter?.event?.price, 29.99)
        XCTAssertEqual(sut.presenter?.event?.title, "Test 1")
        XCTAssertEqual(sut.presenter?.event?.date, 1534784400000)
    }
    
    private func makeSUT() throws -> DetailsViewController {
        
        let event = Event(description: "Test 1", image: self.convertImageToBase64String(img: UIImage(named: "placeholder")!) , longitude: -51.2146267, latitude: -30.0392981, price: 29.99, title: "Test 1", id: "1", date: 1534784400000)
        let sut = DetailsModuleBuilder.build(event: event) as! DetailsViewController
        
        return sut
    }
    
    private func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }

}
