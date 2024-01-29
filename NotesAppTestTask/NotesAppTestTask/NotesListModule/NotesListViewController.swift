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
		self._presenter?.viewDidLoad(tableView: self.tableView, viewController: self)
		// Do any additional setup after loading the view.
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
}
