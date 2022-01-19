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
        EventService.sahred.getEventsService { success, events, error in
            if success {
                
            }
        }
    }
}
