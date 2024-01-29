//
//  NotesListPresenter.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import Foundation

protocol INotesListPresenter: PresenterProtocol
{
	func viewDidLoad(tableView: NotesListView, viewController: NotesListViewController)
}

final class NotesListPresenter
{
	weak var _tableView: NotesListView?
	weak var _viewController: NotesListViewController?
	private var _interactor: NotesListInteractor?
	private var _router: NotesListRouter?
}

extension NotesListPresenter: INotesListPresenter {
	func viewDidLoad(tableView: NotesListView, viewController: NotesListViewController) {
		self._tableView = tableView
		self._tableView?.noteTappedHandler = {
			guard let vc = self._viewController else { return }
			self._router?.openNoteView(viewController: vc)
		}
	}

	var viewController: ViewProtocol? {
		get {
			return self._viewController
		}
		set {
			self._viewController = newValue as? NotesListViewController
		}
	}

	var interactor: InteractorProtocol? {
		get {
			return self._interactor
		}
		set {
			self._interactor = newValue as? NotesListInteractor
		}
	}

	var router: RouterProtocol? {
		get {
			return self._router
		}
		set {
			self._router = newValue as? NotesListRouter
		}
	}


}