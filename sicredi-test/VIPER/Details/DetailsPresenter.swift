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

}
