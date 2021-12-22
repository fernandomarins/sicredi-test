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
    var segue = "toDetails"
    
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
                self.fetchData(events: events)
            } else {
                debugPrint(error)
            }
        }
    }
    
    func fetchData(events: Events) {
        self.events = events
        var vms = [EventCellViewModel]()
        for event in events {
            vms.append(createCellModel(event: event))
        }
        
        eventCellViewModels = vms
    }
    
    func createCellModel(event: Event) -> EventCellViewModel {
        let description = event.description
        let image = event.image
        let longitude = event.longitude
        let latitude = event.latitude
        let price = event.price
        let title = event.title
        let id = event.id
        let date = event.date
        
        return EventCellViewModel(description: description, image: image, longitude: longitude, latitude: latitude, price: price, title: title, id: id, date: date)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> EventCellViewModel {
        return eventCellViewModels[indexPath.row]
    }

    
}
