//
//  ViewController.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

class NotesListViewController: UIViewController {

	private let tableView = NotesListView(frame: .zero, style: .plain)

	override func loadView() {
		super.loadView()
		self.view = self.tableView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

