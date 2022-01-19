//
//  EventsPresenter.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit

class EventsPresenter: EventsPresenterContract {
    
    var router: EventsRouterContract?
    var interactor: EventsInteractorContract?
    var view: EventsContract?
    
    var contentArray: Events
    
    init() {
        contentArray = []
    }
    
    func fetchEvents() {
        view?.toggleActivityIndicator(show: true)
        interactor?.fetchEvents()
    }
    
    func fetchedEvents(output: Events) {
        contentArray = output
        view?.toggleActivityIndicator(show: false)
        view?.updateContent()
    }
    
    func fecthedError(message: String) {
        
    }
    
    func toDetails(contentIndex: Int) {

    }
}
