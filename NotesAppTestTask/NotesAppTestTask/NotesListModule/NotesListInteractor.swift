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
}

final class NotesListInteractor
{
	weak var _presenter: NotesListPresenter?
	var coreData = NotesCoreData.shared
}

extension NotesListInteractor: INotesListInteractor {
	func loadNotes() {
		let request = NoteData.fetchRequest()
		do {
			var notesList: [NotesListEntity] = []
			let entities = try self.coreData.context.fetch(request)
			entities.forEach { entity in
				let id = entity.id
				let title = entity.title
				let body = entity.body
				notesList.append(NotesListEntity(id: id!, title: title!, body: body!))
			}
			self._presenter?.showNotes(notes: notesList)
			print(notesList)
		} catch {
			print("loading error: ------")
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
