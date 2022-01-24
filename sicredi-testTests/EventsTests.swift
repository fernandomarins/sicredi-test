//
//  EventsTests.swift
//  sicredi-testTests
//
//  Created by Fernando Marins on 24/01/22.
//

import XCTest
@testable import sicredi_test

class EventsTests: XCTestCase {
    
    func test_canInit() throws {
        _ = try makeSUT()
    }
    
    func test_viewDidLoad_configuresTableView() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertIdentical(sut.tableView.delegate, sut)
        XCTAssertIdentical(sut.tableView.dataSource, sut)
        
        // or we can test like this
//        XCTAssertNotNil(sut.tableView.delegate, "delegate")
//        XCTAssertNotNil(sut.tableView.dataSource, "delegate")
    }
    
    func test_viewDidLoad_initialState() throws {
        let sut = try makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.numberOfEvents(), 0)
    }
    
    func test_viewDidLoad_rendersEventsFromApi() throws {
        
        let sut = try makeSUT()
        
        // events to test
        let events = [
            Event(description: "Test 1", image: self.convertImageToBase64String(img: UIImage(named: "placeholder")!) , longitude: -51.2146267, latitude: -30.0392981, price: 29.99, title: "Test 1", id: "1", date: 1534784400000),
            Event(description: "Test 2", image: self.convertImageToBase64String(img: UIImage(named: "placeholder")!) , longitude: -51.2146267, latitude: -30.0392981, price: 64.99, title: "Test 2", id: "2", date: 1534784400000)
        ]
        
        sut.presenter?.fetchedEvents(output: events)
        
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.numberOfEvents(), 2)
        
        XCTAssertEqual(sut.title(atRow: 0), "Test 1")
        XCTAssertEqual(sut.title(atRow: 1), "Test 2")
        
//        let date = 1534784400000.convertIntDateToString()
        
//        XCTAssertEqual(sut.date(atRow: 0), date)
//        XCTAssertEqual(sut.date(atRow: 1), date)
    }
    
    private func makeSUT() throws -> EventsView {
        let initialVc = EventsModuleBuilder.build()
        let navigation = UINavigationController(rootViewController: initialVc)
        
        let sut = try XCTUnwrap(navigation.topViewController as? EventsView)
        
        return sut
    }
    
    // convert an image to string in base64
    private func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }

}

extension EventsView {
    
    private var eventsSection: Int { 0 }
    
    func numberOfEvents() -> Int {
        tableView.numberOfRows(inSection: eventsSection)
    }
    
    func title(atRow row: Int) -> String? {
        return eventCell(atRow: row)?.titleLabel.text
    }
    
    func date(atRow row: Int) -> String? {
        return eventCell(atRow: row)?.dateLabel.text
    }
    
    func eventCell(atRow row: Int) -> EventCell? {
        let ds = tableView.dataSource
        let indexPath = IndexPath(row: row, section: eventsSection)
        return ds?.tableView(tableView, cellForRowAt: indexPath) as? EventCell
    }
}
