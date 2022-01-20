//
//  DetailsInteractor.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import Foundation

class DetailsInteractor: DetailsInteractorContract {

    weak var presenter: DetailsPresenterContract?
    
    func performCheckIn(name: String, email: String, eventId: String) {
        EventService.shared.makeCheckIn(eventId: eventId, name: name, email: email) { [weak self] success, error in
            if success == nil {
                self?.presenter?.performedCheckin()
            } else {
                self?.fetchedError(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    private func fetchedError(message: String) {
        presenter?.fetchedError(message: message)
    }

}
