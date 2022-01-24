//
//  ClientAPI.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import Foundation

class Client {
    
    static let shared: Client = Client()
    
    enum Endpoints {
        
        // Declaring the URLs
        static let baseURL = "http://5f5a8f24d44d640016169133.mockapi.io/api"
        static let events = "/events"
        static let checkIn = "/checkin"
        
        // Declaring the cases
        case getEvents
        case makeCheckIn
        
        // Changing the URL according to the endpoint
        var stringValue: String {
            switch self {
            case .getEvents: return Endpoints.baseURL + Endpoints.events
            case .makeCheckIn: return Endpoints.baseURL + Endpoints.checkIn
            }
        }
        
        // Creating the URL
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    // Generic GET request
    class func taskForGETRequest<ResponseType: Decodable>(from url: URL, reponseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }

            do {
                let decoder = JSONDecoder()
                let responseObj = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObj, nil)
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
}
