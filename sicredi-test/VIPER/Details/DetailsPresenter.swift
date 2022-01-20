//
//  DetailsPresenter.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import Foundation

class DetailsPresenter: DetailsPresenterContract {    

    var router: DetailsRouterContract?
    var interactor: DetailsInteractorContract?
    weak var view: DetailsViewContract?
    
    var event: Event?
    
    init(event: Event?) {
        self.event = event
    }

    func performCheckIn(name: String, email: String) {
        interactor?.performCheckIn(name: name, email: email, eventId: event?.id ?? "")
    }
    
    func performedCheckin() {
        view?.checkInDone()
    }
    
    func fetchedError() {
        view?.showError()
    }
}
