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
	private var uuid: UUID?

	init(uuid: UUID?) {
		self.uuid = uuid
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Your new note"
		self.navigationController?.navigationBar.prefersLargeTitles = false
		self.view = self.uiview
		self._presenter?.viewDidLoad(view: uiview, viewController: self)
		guard let id = self.uuid else { return }
		self._presenter?.loadNote(id: id)
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
