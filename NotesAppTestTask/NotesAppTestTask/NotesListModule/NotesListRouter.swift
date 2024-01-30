//
//  NotesListRouter.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

protocol INotesListRouter: AnyObject, RouterProtocol
{
	
}

final class NotesListRouter
{
	
}

extension NotesListRouter: INotesListRouter {
	func openNoteView(viewController: NotesListViewController) {
//		viewController.present(NoteViewController(), animated: true)
		viewController.navigationController?.pushViewController(NoteViewController(), animated: true)
	}
}
