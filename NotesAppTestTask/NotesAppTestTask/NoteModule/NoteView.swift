//
//  NoteView.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 30.01.2024.
//

import UIKit

protocol INoteView: AnyObject
{
	
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

	lazy private var titleTextField: UITextField = {
		let textfield = UITextField()
		textfield.placeholder = "Title of..."
		return textfield
	}()

	lazy private var bodyTextField: UITextField = {
		let textfield = UITextField()
		textfield.placeholder = "Here we go..."
		return textfield
	}()

	init() {
		super.init(frame: .zero)
		self.backgroundColor = .systemBackground
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension NoteView {
	func setupView() {
		titleTextField.translatesAutoresizingMaskIntoConstraints = false
		bodyTextField.translatesAutoresizingMaskIntoConstraints = false

		addSubview(titleTextField)
		addSubview(bodyTextField)

		NSLayoutConstraint.activate([
			titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.Spacing.small),
			titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Spacing.medium),
			titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Spacing.medium),
			titleTextField.heightAnchor.constraint(equalToConstant: Metrics.height),
			bodyTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Metrics.Spacing.medium),
			bodyTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
			bodyTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
			bodyTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.Spacing.medium)
		])

	}
}
