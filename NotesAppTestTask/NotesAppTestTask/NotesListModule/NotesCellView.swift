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

	lazy private var arrowImage: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(systemName: "chevron.right")
		image.tintColor = .systemGray2
		return image
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
		arrowImage.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(title)
		contentView.addSubview(body)
		contentView.addSubview(arrowImage)
		NSLayoutConstraint.activate([
			title.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Spacing.medium),
			title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.large),
			title.trailingAnchor.constraint(equalTo: arrowImage.trailingAnchor, constant: -Metrics.Spacing.large),
			body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Metrics.Spacing.small),
			body.leadingAnchor.constraint(equalTo: title.leadingAnchor),
			body.trailingAnchor.constraint(equalTo: title.trailingAnchor),
			arrowImage.centerYAnchor.constraint(equalTo: centerYAnchor),
			arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.large)
		])
	}

	func setData(note: NotesListEntity) {
		self.title.text = note.title
		self.body.text = note.body
	}
}
