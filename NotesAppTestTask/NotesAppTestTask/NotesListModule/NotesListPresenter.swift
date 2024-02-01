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
	func openNewNoteScreen(viewController: NotesListViewController)
	func showNotes(notes: [NotesListEntity])
	func viewWillAppear()
}

final class NotesListPresenter
{
	weak var _tableView: INotesListView?
	weak var _viewController: NotesListViewController?
	private var _interactor: NotesListInteractor?
	private var _router: NotesListRouter?
}

extension NotesListPresenter: INotesListPresenter {
	func viewWillAppear() {
		self._interactor?.loadNotes()
		self._tableView?.reload()
	}

	func showNotes(notes: [NotesListEntity]) {
		self._tableView?.setData(notes)
		self._tableView?.reload()
	}

	func viewDidLoad(tableView: NotesListView, viewController: NotesListViewController) {
		self._tableView = tableView
		self._interactor?.loadNotes()
		self._tableView?.noteTappedHandler = { uuid in
			self._router?.openNoteView(viewController: viewController, uuid: uuid)
		}
		self._tableView?.swipeForDeleteHandler = { uuid in
			self._interactor?.deleteNote(id: uuid)
			self._tableView?.reload()
		}
	}

	func openNewNoteScreen(viewController: NotesListViewController) {
		self._router?.openNoteView(viewController: viewController, uuid: nil)
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
