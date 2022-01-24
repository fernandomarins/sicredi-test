//
//  EventService.swift
//  sicredi-test
//
//  Created by Fernando Marins on 17/12/21.
//

import Foundation
import UIKit

protocol EventServiceProtocol {
    func getEventsService(completion: @escaping (Result<Events?, Error>) -> ())
    
    func makeCheckIn(eventId: String, name: String, email: String, completion: @escaping (Bool?, Error?) -> Void)
}

class EventService: EventServiceProtocol {
    
    static let shared = EventService()
    
    func getEventsService(completion: @escaping (Result<Events?, Error>) -> ()) {
        
        let url = Client.Endpoints.getEvents.url
        Client.taskForGETRequest(from: url, reponseType: [Event].self) { response, error in
            if let response = response {
                completion(.success(response))
            }
            
            if let error = error {
                completion(.failure(error))
            }
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
