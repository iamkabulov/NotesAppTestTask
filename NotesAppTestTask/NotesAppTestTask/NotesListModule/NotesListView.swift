//
//  NotesListView.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

protocol INotesListView: AnyObject
{
	var noteTappedHandler: ((UUID) -> Void)? { get set }
	var swipeForDeleteHandler: ((UUID) -> Void)? { get set }
	func setData(_ notes: [NotesListEntity])
	func reload()
}

final class NotesListView: UITableView
{
	private let tableView = UITableView()
	var noteTappedHandler: ((UUID) -> Void)?
	var swipeForDeleteHandler: ((UUID) -> Void)?
	private var notes: [NotesListEntity] = []

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		self.configureTableView()
		self.setupTableView()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension NotesListView: INotesListView {
	func reload() {
		self.tableView.reloadData()
	}

	func setData(_ notes: [NotesListEntity]) {
		let sorted = notes.sorted { $0.date > $1.date }
		self.notes = sorted
	}

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
		notes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: NotesCellView.reuseId, for: indexPath) as? NotesCellView
		//TODO: -
		guard let cell = cell else { return UITableViewCell() }
		cell.setData(note: notes[indexPath.item])


		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let id = notes[indexPath.item].id
			swipeForDeleteHandler?(id)
			notes.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

//MARK: - UITableViewDelegate
extension NotesListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		let id = notes[indexPath.item].id
		noteTappedHandler?(id)
	}
}

