//
//  ModuleBuilder.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

class ModuleBuilder<ModuleView: ViewProtocol, ModuleInteractor: InteractorProtocol, ModulePresenter: PresenterProtocol, ModuleRouter: RouterProtocol> {
	private var view: ModuleView?
	private var interactor: ModuleInteractor?
	private var presenter: ModulePresenter?
	private var router: ModuleRouter?

	func setView(_ view: ModuleView) -> Self {
		self.view = view
		return self
	}

	func setInteractor(_ interactor: ModuleInteractor) -> Self {
		self.interactor = interactor
		return self
	}

	func setPresenter(_ presenter: ModulePresenter) -> Self {
		self.presenter = presenter
		return self
	}

	func setRouter(_ router: ModuleRouter) -> Self {
		self.router = router
		return self
	}

	func buildModule() -> ViewProtocol? {
		guard let view = view,
			  let interactor = interactor,
			  let presenter = presenter else { return nil }


		presenter.viewController = view
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter
//		router.view = view
		view.presenter = presenter

		return view
	}
}

//MARK: - ViewProtocol
protocol ViewProtocol: AnyObject {
	var presenter: PresenterProtocol? { get set }
}

//MARK: - InteractorProtocol
protocol InteractorProtocol: AnyObject {
	var presenter: PresenterProtocol? { get set }
}

//MARK: - PresenterProtocol
protocol PresenterProtocol: AnyObject {
	var viewController: ViewProtocol? { get set }
	var interactor: InteractorProtocol? { get set }
	var router: RouterProtocol? { get set }
}

//MARK: - RouterProtocol
protocol RouterProtocol: AnyObject {
}
