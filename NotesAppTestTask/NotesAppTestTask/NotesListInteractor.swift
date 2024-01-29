//
//  NotesListInteractor.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import Foundation

protocol INotesListInteractor: InteractorProtocol
{
	
}

final class NotesListInteractor
{
	weak var _presenter: NotesListPresenter?
}

extension NotesListInteractor: INotesListInteractor {
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? NotesListPresenter
		}
	}


}
