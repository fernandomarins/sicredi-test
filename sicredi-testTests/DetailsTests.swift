//
//  DetailsTests.swift
//  sicredi-testTests
//
//  Created by Fernando Marins on 24/01/22.
//

import XCTest

@testable import sicredi_test

class DetailsTests: XCTestCase {

    func test_canInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_initialState() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNil(sut.presenter?.event)
    }
    
//    func test_viewDidLoad_rendersEventsFromApi() throws {
//
//        let sut = try makeSUT()
//
//        // events to test
//        let events = [
//            Event(description: "Test 1", image: self.convertImageToBase64String(img: UIImage(named: "placeholder")!) , longitude: -51.2146267, latitude: -30.0392981, price: 29.99, title: "Test 1", id: "1", date: 1534784400000),
//            Event(description: "Test 2", image: self.convertImageToBase64String(img: UIImage(named: "placeholder")!) , longitude: -51.2146267, latitude: -30.0392981, price: 64.99, title: "Test 2", id: "2", date: 1534784400000)
//        ]
//
//        sut.presenter?.fetchedEvents(output: events)
//
//        sut.loadViewIfNeeded()
//
//        XCTAssertEqual(sut.numberOfEvents(), 2)
//
//        XCTAssertEqual(sut.title(atRow: 0), "Test 1")
//        XCTAssertEqual(sut.title(atRow: 1), "Test 2")
//
////        let date = 1534784400000.convertIntDateToString()
//
////        XCTAssertEqual(sut.date(atRow: 0), date)
////        XCTAssertEqual(sut.date(atRow: 1), date)
//    }
    
    private func makeSUT() throws -> DetailsViewController {
        
        let sut = DetailsViewController()
//        let initialVc = EventsModuleBuilder.build()
//        let navigation = UINavigationController(rootViewController: initialVc)
//
//
//
//        let sut = try XCTUnwrap(navigation. as? EventsView)
//
        return sut
    }

}
