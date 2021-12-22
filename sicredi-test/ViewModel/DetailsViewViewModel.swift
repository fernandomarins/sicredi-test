//
//  DetailsViewViewModel.swift
//  sicredi-test
//
//  Created by Fernando Marins on 17/12/21.
//

import Foundation
import UIKit

class DetailsViewViewModel {
    
    private var eventService: EventServiceProtocol
    
    var description: String?
    var image: String?
    var longitude: Double?
    var latitude: Double?
    var price: Double?
    var title: String?
    var date: Int?
    
    // Creaeting the string to share
    var urlString: String {
        return Client.Endpoints.baseURL + Client.Endpoints.events + "\(String(describing: event?.id))"
    }
    
    var event: Event? {
        didSet {
            self.description = event?.description
            self.image = event?.image
            self.longitude = event?.longitude
            self.latitude = event?.latitude
            self.price = event?.price
            self.title = event?.title
            self.date = event?.date
        }
    }

    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    func getImageFromUrl(completion: @escaping(Data?, Error?) -> Void) {
        let url = URL(string: event!.image)
        eventService.loadImageService(url: url!) { success, data, error in
            if success, let data = data {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func makeCheckIn(name: String, email: String, completion: @escaping (Bool?, Error?) -> Void ) {
        eventService.makeCheckIn(eventId: event?.id ?? "", name: name, email: email) { success, error in
            if let success = success {
                completion(success, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
