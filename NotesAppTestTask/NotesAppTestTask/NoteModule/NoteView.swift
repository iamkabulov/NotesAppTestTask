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
		textfield.text = "Title of..."
		textfield.textColor = .lightGray
		textfield.font = UIFont.preferredFont(forTextStyle: .headline)
		return textfield
	}()

	lazy private var bodyTextField: UITextView = {
		let textView = UITextView()
		textView.text = "Here we go..."
		textView.textColor = .lightGray
		textView.font = UIFont.preferredFont(forTextStyle: .body)
		return textView
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

		addSubview(titleTextField)
		addSubview(bodyTextField)

		NSLayoutConstraint.activate([
			titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.Spacing.small),
			titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.large),
			titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.medium),
			titleTextField.heightAnchor.constraint(equalToConstant: Metrics.height),
			bodyTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Metrics.Spacing.medium),
			bodyTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			bodyTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
			bodyTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.Spacing.medium)
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
								   body: bodyTextField.text)
		}
		else {
			note = NotesListEntity(id: UUID(),
								   title: titleTextField.text,
								   body: bodyTextField.text)
		}

		return note
	}

	func showNote(_ note: NotesListEntity) {
		titleTextField.textColor = .black
		bodyTextField.textColor = .black

		id = note.id
		titleTextField.text = note.title
		bodyTextField.text = note.body
	}
}

//MARK: - TextFieldDelegate
extension NoteView: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField.textColor == .lightGray {
			textField.text = nil
			textField.textColor = .black
		}
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text == "" {
			textField.text = "Title of..."
			textField.textColor = .lightGray
		}
	}
}

//MARK: - TextViewDelegate
extension NoteView: UITextViewDelegate {

	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == .lightGray {
			textView.text = nil
			textView.textColor = .black
		}
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "Here we go..."
			textView.textColor = .lightGray
		}
	}
}
