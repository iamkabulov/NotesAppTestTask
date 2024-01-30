//
//  NoteInteractor.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 30.01.2024.
//

import Foundation

protocol INoteInteractor: InteractorProtocol
{

}

final class NoteInteractor
{
	weak var _presenter: NotesListPresenter?
}

extension NoteInteractor: INoteInteractor {
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? NotesListPresenter
		}
	}


}
