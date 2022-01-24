//
//  EventsInteractor.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit

typealias getAllEvents = (@escaping (Result<Events?, Error>) -> ()) -> Void

class EventsInteractor: EventsInteractorContract {
    
    var getEvents: getAllEvents = EventService.shared.getEventsService
    
    weak var presenter: EventsPresenterContract?
    
    func fetchEvents() {
        getEvents { result in
            switch result {
            case .success(let events):
                self.presenter?.fetchedEvents(output: events ?? [])
            case .failure(let error):
                self.fetchedError(message: error.localizedDescription)
            }
        }
    }
    
    private func fetchedError(message: String) {
        presenter?.fecthedError(message: message)
    }
}
