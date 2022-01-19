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
    
    func updateContent()
}

// MARK: Presenter -
protocol EventsPresenterContract: AnyObject {
    var router: EventsRouterContract? { get set }
    var interactor: EventsInteractorContract? { get set }
    var view: EventsContract? { get set }
    
    var contentArray: Events { get }
    
    func fetchEvents()
    
    func toDetails(contentIndex: Int)
}

// MARK: Interactor -
protocol EventsInteractorContract: AnyObject {
    var presenter: EventsPresenterContract? { get set }
}

// MARK: Router -
protocol EventsRouterContract: AnyObject {
    var presenter: EventsPresenterContract? { get set }
    var view: EventsContract? { get set }
    
    func toDetails(event: Event)
}

// MARK: Builder -
struct EventsModuleBuilder {
//    static func build() -> UIViewController {
//
//    }
}
