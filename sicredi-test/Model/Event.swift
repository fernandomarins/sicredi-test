//
//  Event.swift
//  sicredi-test
//
//  Created by Fernando Marins on 15/12/21.
//

import Foundation

struct Event: Decodable {
    let date: String
    let description: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String
}
