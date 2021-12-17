//
//  Event.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import Foundation

typealias Events = [Event]

struct Event: Decodable {
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String
    let date: Int
}
