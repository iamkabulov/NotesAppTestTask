//
//  NotePresenter.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 30.01.2024.
//

import Foundation

protocol INotePresenter: PresenterProtocol
{
	func viewDidLoad(view: NoteView, viewController: NoteViewController)
}

final class NotePresenter
{
	weak var _view: NoteView?
	weak var _viewController: NoteViewController?
	private var _interactor: NoteInteractor?
	private var _router: NoteRouter?
}

extension NotePresenter: INotePresenter {
	func viewDidLoad(view: NoteView, viewController: NoteViewController) {
		self._view = view
	}

	var viewController: ViewProtocol? {
		get {
			return self._viewController
		}
		set {
			self._viewController = newValue as? NoteViewController
		}
	}

	var interactor: InteractorProtocol? {
		get {
			return self._interactor
		}
		set {
			self._interactor = newValue as? NoteInteractor
		}
	}

	var router: RouterProtocol? {
		get {
			return self._router
		}
		set {
			self._router = newValue as? NoteRouter
		}
	}


}
