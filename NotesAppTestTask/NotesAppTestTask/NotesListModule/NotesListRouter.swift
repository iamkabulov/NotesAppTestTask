//
//  NotesListRouter.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

protocol INotesListRouter: RouterProtocol
{
	
}

final class NotesListRouter
{
	
}

extension NotesListRouter: INotesListRouter {
	func openNoteView(viewController: NotesListViewController) {
		let noteInteractor = NoteInteractor()
		let noteRouter = NoteRouter()
		let notePresenter = NotePresenter()
		let noteViewController = NoteViewController()

		let noteBuilder = ModuleBuilder<NoteViewController, NoteInteractor, NotePresenter, NoteRouter>()

		guard let noteModule = noteBuilder.setView(noteViewController)
			.setInteractor(noteInteractor)
			.setPresenter(notePresenter)
			.setRouter(noteRouter)
			.buildModule() as? UIViewController else { return }
		
		viewController.navigationController?.pushViewController(noteModule, animated: true)
	}
}
