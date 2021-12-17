//
//  EventService.swift
//  sicredi-test
//
//  Created by Fernando Marins on 17/12/21.
//

import Foundation

protocol EventServiceProtocol {
    func getEventsService(completion: @escaping (_ success: Bool, _ results: Events?, _ error: Error?) -> ())
}

class EventService: EventServiceProtocol {
    func getEventsService(completion: @escaping (Bool, Events?, Error?) -> ()) {
        Client.getEvents { events, error in
            guard let error = error else {
                completion(false, nil, error)
                return
            }
            completion(true, events, nil)

        }
    }
}
