//
//  NotesListView.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

protocol INotesListView: AnyObject
{
	
}

final class NotesListView: UITableView
{
	private let tableView = UITableView()

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		self.configureTableView()
		self.setupTableView()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension NotesListView {
	func setupTableView() {
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(tableView)

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func configureTableView() {

		self.tableView.register(NotesCellView.self, forCellReuseIdentifier: NotesCellView.reuseId)
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.rowHeight = NotesCellView.rowHeight
	}
}

//MARK: - UITableViewDataSource
extension NotesListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		11
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: NotesCellView.reuseId, for: indexPath) as? NotesCellView
		//TODO: -
		guard let cell = cell else { return UITableViewCell() }

		return cell
	}


}

//MARK: - UITableViewDelegate
extension NotesListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
	}
}

