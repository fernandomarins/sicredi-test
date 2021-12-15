//
//  ClientAPI.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import Foundation

class Client {
    
    enum Endpoints {
        
        static let baseURL = "http://5f5a8f24d44d640016169133.mockapi.io/api/"
        static let events = "/events"
        static let checkIn = "/checkin"
        
        case getEvents
        case makeCheckIn
        
        var stringValue: String {
            switch self {
            case .getEvents: return Endpoints.baseURL + Endpoints.events
            case .makeCheckIn: return Endpoints.baseURL + Endpoints.checkIn
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
}
