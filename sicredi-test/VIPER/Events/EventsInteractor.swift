//
//  EventsInteractor.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit

class EventsInteractor: EventsInteractorContract {
    
    weak var presenter: EventsPresenterContract?
    
    func fetchEvents() {
        EventService.shared.getEventsService { [weak self] success, events, error in
            
            if let error = error {
                self?.fetchedError(message: error.localizedDescription)
            }
            
            guard let events = events else {
                return
            }
            
            self?.presenter?.fetchedEvents(output: events)
        }
    }
    
    private func fetchedError(message: String) {
        presenter?.fecthedError(message: message)
    }
}
