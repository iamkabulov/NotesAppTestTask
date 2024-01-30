//
//  NoteViewController.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

final class NoteViewController: UIViewController
{
	private let uiview = NoteView()
	private var _presenter: NotePresenter?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Your new note"
		self.navigationController?.navigationBar.prefersLargeTitles = false
		self.view = self.uiview
		// Do any additional setup after loading the view.
	}


}

extension NoteViewController: ViewProtocol
{
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? NotePresenter
		}
	}
}
