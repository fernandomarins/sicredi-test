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
}

//MARK: Presenter -
protocol DetailsPresenterContract: AnyObject {
    var router: DetailsRouterContract? { get set }
    var interactor: DetailsInteractorContract? { get set }
    var view: DetailsViewContract? { get set }
}

//MARK: Interactor -
protocol DetailsInteractorContract: AnyObject {
    var presenter: DetailsPresenterContract? { get set }
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
        let presenter = DetailsPresenter()
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
