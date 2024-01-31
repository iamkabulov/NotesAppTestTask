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
	func loadNote(id: UUID)
	func showNote(_ note: NotesListEntity?)
	func saveNote(_ note: NotesListEntity?)
}

final class NotePresenter
{
	weak var _view: INoteView?
	weak var _viewController: NoteViewController?
	private var _interactor: NoteInteractor?
	private var _router: NoteRouter?
}

//MARK: - INotePresenter
extension NotePresenter: INotePresenter {
	func saveNote(_ note: NotesListEntity?) {
		guard let note = note else { return } //TODO: - Make alert
		self._interactor?.saveNote(note)
	}

	func showNote(_ note: NotesListEntity?) {
		guard let note = note else { return }
		self._view?.showNote(note)
	}

	func loadNote(id: UUID) {
		self._interactor?.loadNoteBy(id: id)
	}

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
