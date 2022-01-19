//
//  EventsPresenter.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit

class EventsPresenter: EventsPresenterContract {
    func fetchEvents() {
        
    }
    
    func toDetails(contentIndex: Int) {
        
    }
    
    
    var router: EventsRouterContract?
    var interactor: EventsInteractorContract?
    var view: EventsContract?
    
    var contentArray: Events
    
    init() {
        contentArray = []
    }
    
    func toEventsDetail(contentIndex: Int) {
//        router
    }
}
