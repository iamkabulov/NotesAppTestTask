//
//  NotesCellView.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 29.01.2024.
//

import UIKit

final class NotesCellView: UITableViewCell
{
	static let reuseId = "NotesCellViewId"
	static let rowHeight: CGFloat = 60

	private enum Metrics {
		static let height: CGFloat = 32
		static let width: CGFloat = 56
		enum Spacing {
			static let small: CGFloat = 4
			static let medium: CGFloat = 8
			static let large: CGFloat = 16
		}
	}

	lazy private var title: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "TITLE"
		label.font = .preferredFont(forTextStyle: .headline)
		return label
	}()

	lazy private var body: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.text = "Body"
		label.font = .preferredFont(forTextStyle: .body)
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupCellView()

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension NotesCellView {
	func setupCellView() {
		title.translatesAutoresizingMaskIntoConstraints = false
		body.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(title)
		contentView.addSubview(body)
		NSLayoutConstraint.activate([
			title.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Spacing.medium),
			title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.large),
			title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.large),
			body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Metrics.Spacing.small),
			body.leadingAnchor.constraint(equalTo: title.leadingAnchor),
			body.trailingAnchor.constraint(equalTo: title.trailingAnchor)
		])
	}
}
