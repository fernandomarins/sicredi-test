//
//  EventsRouter.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit

class EventsRouter: EventsRouterContract {
    
    weak var presenter: EventsPresenterContract?
    weak var view: EventsContract?
    
    func toDetails(event: Event) {
        let viewController = DetailsModuleBuilder.build(event: event)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
