//
//  EventService.swift
//  sicredi-test
//
//  Created by Fernando Marins on 17/12/21.
//

import Foundation
import UIKit

protocol EventServiceProtocol {
    func getEventsService(completion: @escaping (_ success: Bool, _ results: Events?, _ error: Error?) -> ())
    func loadImageService(url: URL, completion: @escaping (_ success: Bool, _ data: Data?, _ error: Error?) -> Void)
    func makeCheckIn(eventId: String, name: String, email: String, completion: @escaping (Bool?, Error?) -> Void)
}

class EventService: EventServiceProtocol {
    
    func getEventsService(completion: @escaping (Bool, Events?, Error?) -> ()) {
        Client.getEvents { events, error in
            guard let events = events else {
                debugPrint(error)
                completion(false, nil, error)
                return
            }
            completion(true, events, nil)

        }
    }
    
    func loadImageService(url: URL, completion: @escaping (Bool, Data?, Error?) -> Void) {
        
        Client.downloadImage(from: url) { data, error in
            if let error = error {
                completion(false, nil, error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            completion(true, data, nil)
        }
    }
    
    func makeCheckIn(eventId: String, name: String, email: String, completion: @escaping (Bool?, Error?) -> Void) {
        Client.checkIn(eventId: eventId, name: name, email: email) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard response?.getStatusCode() == 200 else {
                completion(false, error)
                return
            }
            
            completion(true, nil)

        }
    }
}