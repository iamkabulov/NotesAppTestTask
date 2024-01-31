//
//  ViewController.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

class NotesListViewController: UIViewController {

	private let tableView = NotesListView()
	private var _presenter: NotesListPresenter?

	override func loadView() {
		super.loadView()
		self.view = self.tableView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Notes"
		let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(openNewNoteScreen))
		self.navigationItem.rightBarButtonItem  = addButton
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self._presenter?.viewDidLoad(tableView: self.tableView, viewController: self)
		// Do any additional setup after loading the view.
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self._presenter?.viewWillAppear()
	}

}

extension NotesListViewController: ViewProtocol
{
	var presenter: PresenterProtocol? {
		get {
			return self._presenter
		}
		set {
			self._presenter = newValue as? NotesListPresenter
		}
	}

	@objc func openNewNoteScreen() {
		self._presenter?.openNewNoteScreen(viewController: self)
	}
}
