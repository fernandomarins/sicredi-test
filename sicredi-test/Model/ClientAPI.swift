//
//  ClientAPI.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import Foundation

class Client {
    
    enum Endpoints {
        
        static let baseURL = "http://5f5a8f24d44d640016169133.mockapi.io/api"
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
    
    class func getEvents(completion: @escaping([Event]?, Error?) -> Void) {
        let url = Endpoints.getEvents.url
        taskForGETRequest(from: url, reponseType: [Event].self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion([], error)
            }
        }
        
    }
    
    class func downloadImage(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            completion(data, nil)
        }
        
        task.resume()
    }
    
    class func checkIn(eventId: String, name: String, email: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = Endpoints.makeCheckIn.url
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        
        task.resume()
    }
    
}
