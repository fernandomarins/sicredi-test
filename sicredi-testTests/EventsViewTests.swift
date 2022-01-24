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
        
//        sut.presenter?.interactor?.getEvents
//        sut.presenter?.interactor?.api?.getEventsService(completion: { [weak self] success, results, error in
//            if success {
//                let event = Event(description: "O Patas Dadas estará na Redenção, nesse domingo, com cães para adoção e produtos à venda!\n\nNa ocasião, teremos bottons, bloquinhos e camisetas!\n\nTraga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarão prontinhos para ganhar o ♥ de um humano bem legal pra chamar de seu. \n\nAceitaremos todos os tipos de doação:\n- guias e coleiras em bom estado\n- ração (as que mais precisamos no momento são sênior e filhote)\n- roupinhas \n- cobertas \n- remédios dentro do prazo de validade", image: self?.convertImageToBase64String(img: UIImage(named: "placeholder")!) ?? "", longitude: -51.2146267, latitude: -30.0392981, price: 29.99, title: "Feira de adoção de animais na Redenção", id: "1", date: 1534784400000)
//            }
//        })
        
        sut.loadViewIfNeeded()
        
//        sut.presenter?.fetchEvents()
        
        let exp = expectation(description: "Wait for API")
        exp.isInverted = true
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), sut.presenter?.contentArray.count)
    }
    
    private func makeSUT() throws -> EventsView {
        let initialVc = EventsModuleBuilder.build()
        let navigation = UINavigationController(rootViewController: initialVc)
        
        let sut = try XCTUnwrap(navigation.topViewController as? EventsView)
        
//        sut.presenter?.interactor?.api = EventServiceStub()
        
//        sut.presenter?.interactor?.api?.getEventsService(completion: { _, _, _ in } )
        
        return sut
    }
    
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
