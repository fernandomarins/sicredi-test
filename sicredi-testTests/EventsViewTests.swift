//
//  EventsViewTests.swift
//  sicredi-testTests
//
//  Created by Fernando Marins on 24/01/22.
//

import XCTest
@testable import sicredi_test

class EventsViewTests: XCTestCase {
    
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
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_rendersEventsFromApi() throws {
        
        let sut = try makeSUT()
        
        let events = [
            Event(description: "Test 1", image: self.convertImageToBase64String(img: UIImage(named: "placeholder")!) , longitude: -51.2146267, latitude: -30.0392981, price: 29.99, title: "Feira de adoção de animais na Redenção", id: "1", date: 1534784400000),
            Event(description: "Test 2", image: self.convertImageToBase64String(img: UIImage(named: "placeholder")!) , longitude: -51.2146267, latitude: -30.0392981, price: 64.99, title: "Feira de adoção de animais na Redenção", id: "2", date: 1534784400000)
        ]
        
        sut.presenter?.fetchedEvents(output: events)
        
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }
    
    private func makeSUT() throws -> EventsView {
        let initialVc = EventsModuleBuilder.build()
        let navigation = UINavigationController(rootViewController: initialVc)
        
        let sut = try XCTUnwrap(navigation.topViewController as? EventsView)
        
//        sut.presenter?.interactor?.getEvents = { _ in }
        return sut
    }
    
    // convert an image to string in base64
    private func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

private class EventServiceStub: EventServiceProtocol {
    
    func getEventsService(completion: @escaping (Result<Events?, Error>) -> ()) {
        
    }
    
    func makeCheckIn(eventId: String, name: String, email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        
    }
}
