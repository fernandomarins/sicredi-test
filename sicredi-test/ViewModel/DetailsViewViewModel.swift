//
//  DetailsViewViewModel.swift
//  sicredi-test
//
//  Created by Fernando Marins on 17/12/21.
//

import Foundation
import UIKit

class DetailsViewViewModel {
    
    var description: String?
    var image: String?
    var longitude: Double?
    var latitude: Double?
    var price: Double?
    var title: String?
    var date: Int?
    
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
    
    private var eventService: EventServiceProtocol

    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    func getImageFromUrl(completion: @escaping(Data?, Error?) -> Void) {
        let url = URL(string: event!.image)
        eventService.loadImage(url: url!) { success, data, error in
            if success, let data = data {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
