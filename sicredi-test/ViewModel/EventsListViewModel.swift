//
//  EventsListViewModel.swift
//  sicredi-test
//
//  Created by Fernando Marins on 17/12/21.
//

import Foundation

class EventsListViewModel {
    
    var reloadedTableView: (() -> Void)?
    var events = Events()
    
    private var eventService: EventServiceProtocol
    
    var eventCellViewModels = [EventCellViewModel]() {
        didSet {
            reloadedTableView?()
        }
    }
    
    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    func getEvents() {
        eventService.getEventsService { success, results, error in
            if success, let events = results {
//                self.fetchData()
            }
        }
    }
    
    func fetchData(events: Events) {
        self.events = events
        var vms = [EventCellViewModel]()
        for event in events {
//            vms.append(<#T##newElement: EventCellViewModel##EventCellViewModel#>)
        }
    }

    
}
