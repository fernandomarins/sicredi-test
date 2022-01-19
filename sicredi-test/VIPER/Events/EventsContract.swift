//
//  EventsContract.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit

// MARK: View -
protocol EventsContract: UIViewController {
    var presenter: EventsPresenterContract? { get set }
    
    func toggleActivityIndicator(show: Bool)
    
    func showError(message: String)
    
    func updateContent()
}

// MARK: Presenter -
protocol EventsPresenterContract: AnyObject {
    var router: EventsRouterContract? { get set }
    var interactor: EventsInteractorContract? { get set }
    var view: EventsContract? { get set }
    
    var contentArray: Events { get }
    
    func fetchEvents()
    func fetchedEvents(output: Events)
    func fecthedError(message: String)
    
    func toDetails(contentIndex: Int)
}

// MARK: Interactor -
protocol EventsInteractorContract: AnyObject {
    var presenter: EventsPresenterContract? { get set }
    
    func fetchEvents()
}

// MARK: Router -
protocol EventsRouterContract: AnyObject {
    var presenter: EventsPresenterContract? { get set }
    var view: EventsContract? { get set }
    
    func toDetails(event: Event)
}

// MARK: Builder -
struct EventsModuleBuilder {
    static func build() -> UIViewController {
        let view = EventsView()
        let interactor = EventsInteractor()
        let presenter = EventsPresenter()
        let router = EventsRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.presenter = presenter
        router.view = view
        
        return view
    }
}
