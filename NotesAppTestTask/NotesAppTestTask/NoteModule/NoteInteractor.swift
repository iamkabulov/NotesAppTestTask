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
	private var coreData = NotesCoreData.shared
}

//MARK: - INoteInteractor
extension NoteInteractor: INoteInteractor {

	func saveNote(_ note: NotesListEntity){
		coreData.saveNote(note)
		
	}

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
