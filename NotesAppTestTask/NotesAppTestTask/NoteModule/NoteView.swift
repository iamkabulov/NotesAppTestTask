//
//  NoteView.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 30.01.2024.
//

import UIKit

protocol INoteView: AnyObject
{
	func showNote(_ note: NotesListEntity)
	func getData() -> NotesListEntity?
}

final class NoteView: UIView
{
	private enum Metrics {
		static let height: CGFloat = 32
		static let width: CGFloat = 56
		enum Spacing {
			static let small: CGFloat = 4
			static let medium: CGFloat = 8
			static let large: CGFloat = 16
		}
	}

	private var id: UUID?

	lazy private var titleTextField: UITextField = {
		let textfield = UITextField()
		textfield.placeholder = "Title of..."
		textfield.font = UIFont.preferredFont(forTextStyle: .headline)
		return textfield
	}()

	lazy private var bodyTextField: UITextView = {
		let textView = UITextView()
		textView.layer.borderColor = UIColor.black.cgColor
		textView.layer.borderWidth = 0.2
		textView.layer.cornerRadius = 3
//		textView.text = "Here we go..."
//		textView.textColor = .lightGray
		textView.font = UIFont.preferredFont(forTextStyle: .body)
		return textView
	}()

	lazy private var dateLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = .preferredFont(forTextStyle: .footnote)
		return label
	}()

	init() {
		super.init(frame: .zero)
		self.backgroundColor = .systemBackground
		setupView()
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension NoteView {
	func setupView() {
		titleTextField.translatesAutoresizingMaskIntoConstraints = false
		bodyTextField.translatesAutoresizingMaskIntoConstraints = false
		dateLabel.translatesAutoresizingMaskIntoConstraints = false

		addSubview(titleTextField)
		addSubview(bodyTextField)
		addSubview(dateLabel)

		NSLayoutConstraint.activate([
			titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.Spacing.small),
			titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.large),
			titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.medium),
			titleTextField.heightAnchor.constraint(equalToConstant: Metrics.height),
			bodyTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Metrics.Spacing.medium),
			bodyTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			bodyTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
			bodyTextField.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -Metrics.Spacing.medium),
			dateLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
			dateLabel.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
			dateLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.Spacing.medium)
		])
	}

	func configureView() {
		titleTextField.delegate = self
		bodyTextField.delegate = self
	}
}

//MARK: - INoteView
extension NoteView: INoteView {

	func getData() -> NotesListEntity? {
		var note: NotesListEntity
		if let id = id {
			note = NotesListEntity(id: id,
								   title: titleTextField.text,
								   body: bodyTextField.text,
								   date: Date.now)
		}
		else {
			note = NotesListEntity(id: UUID(),
								   title: titleTextField.text,
								   body: bodyTextField.text,
								   date: Date.now)
		}
		return note
	}

	func showNote(_ note: NotesListEntity) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .short

		let formattedDate = dateFormatter.string(from: note.date)

		id = note.id
		titleTextField.text = note.title
		bodyTextField.text = note.body
		dateLabel.text = formattedDate
	}
}

//MARK: - TextFieldDelegate
extension NoteView: UITextFieldDelegate {

}

//MARK: - TextViewDelegate
extension NoteView: UITextViewDelegate {

	/// self made placeholder
//	func textViewDidBeginEditing(_ textView: UITextView) {
//		if textView.textColor == .lightGray {
//			textView.text = nil
//			textView.textColor = .black
//		}
//	}
//	/// self made placeholder
//	func textViewDidEndEditing(_ textView: UITextView) {
//		if textView.text.isEmpty {
//			textView.text = "Here we go..."
//			textView.textColor = .lightGray
//		}
//	}
}
