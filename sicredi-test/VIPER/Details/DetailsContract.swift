//
//  DetailsContract.swift
//  sicredi-test
//
//  Created by Fernando Marins on 19/01/22.
//

import UIKit

//MARK: View -
protocol DetailsViewContract: AnyObject {
    var presenter: DetailsPresenterContract? { get set }
    
    func getUserInfo()
    func checkInDone()
    func showError()
}

//MARK: Presenter -
protocol DetailsPresenterContract: AnyObject {
    var router: DetailsRouterContract? { get set }
    var interactor: DetailsInteractorContract? { get set }
    var view: DetailsViewContract? { get set }
    
    var event: Event? { get }
    
    func performCheckIn(name: String, email: String)
    func performedCheckin()
    
    func fetchedError()
}

//MARK: Interactor -
protocol DetailsInteractorContract: AnyObject {
    var presenter: DetailsPresenterContract? { get set }
    
    func performCheckIn(name: String, email: String, eventId: String)
}

//MARK: Router -
protocol DetailsRouterContract: AnyObject {
    var presenter: DetailsPresenterContract? { get set }
    var view: DetailsViewContract? { get set }
}

//MARK: Builder -
struct DetailsModuleBuilder {
    static func build(event: Event) -> UIViewController {
        let view = DetailsViewController()
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter(event: event)
        let router = DetailsRouter()

        view.presenter = presenter

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router

        interactor.presenter = presenter

        router.presenter = presenter
        router.view = view

        return view
    }
}
