//
//  NotesListInteractor.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import Foundation

protocol INotesListInteractor: InteractorProtocol
{
	func loadNotes()
	func deleteNote(id: UUID)
}

final class NotesListInteractor
{
	weak var _presenter: NotesListPresenter?
	var coreData = NotesCoreData.shared
}

extension NotesListInteractor: INotesListInteractor {

	func deleteNote(id: UUID) {
		self.coreData.deleteNote(id: id)
	}

	func loadNotes() {
		self.coreData.loadNotes { notesList in
			self._presenter?.showNotes(notes: notesList)
		}
	}

	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? NotesListPresenter
		}
	}


}
