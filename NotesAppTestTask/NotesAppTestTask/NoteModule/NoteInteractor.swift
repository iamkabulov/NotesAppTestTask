//
//  NoteInteractor.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 30.01.2024.
//

import Foundation

protocol INoteInteractor: InteractorProtocol
{
	func loadNoteBy(id: UUID)
}

final class NoteInteractor
{
	weak var _presenter: NotePresenter?
	var coreData = NotesCoreData.shared
}

extension NoteInteractor: INoteInteractor {
	func loadNoteBy(id: UUID) {
		coreData.getNoteBy(id: id) { note in
			self._presenter?.showNote(note)
		}
	}

	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? NotePresenter
		}
	}


}
