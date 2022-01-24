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
        EventService.shared.makeCheckIn(eventId: eventId, name: name, email: email) { result in
            switch result {
            case .success(_):
                self.presenter?.performedCheckin()
            case .failure(_):
                self.fetchedError()
            }
        }
    }
    
    private func fetchedError() {
        presenter?.fetchedError()
    }

}
