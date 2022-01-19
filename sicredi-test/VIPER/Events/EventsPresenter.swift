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
    weak var view: EventsContract?
    
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
        view?.toggleActivityIndicator(show: false)
        view?.showError(message: message)
    }
    
    func toDetails(contentIndex: Int) {
        router?.toDetails(event: contentArray[contentIndex])
    }
}
