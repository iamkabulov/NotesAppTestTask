//
//  Notes+CoreData.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 31.01.2024.
//

import Foundation
import CoreData


public class Note: NSManagedObject {

}

extension Note {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<NoteData> {
		return NSFetchRequest<NoteData>(entityName: "NoteData")
	}

	@NSManaged public var id: UUID
	@NSManaged public var title: String
	@NSManaged public var body: String

}

extension Note: Identifiable {

}

public class NotesCoreData {

	let container: NSPersistentContainer
	let context: NSManagedObjectContext
	static let shared = NotesCoreData()

	private init() {
		self.container = NSPersistentContainer(name: "NotesData")
		self.context = container.viewContext
		self.container.loadPersistentStores { _, error in
			guard let error = error else { return }
			print(error)
			print("Container: Something went wrong")
		}
	}

	func saveContext() {
		do {
			try context.save()
		} catch {
			fatalError("Unresolved error \(error)")
		}
	}

	func saveNote(_ note: NotesListEntity) {
		let fetchRequest = Note.fetchRequest()
		fetchRequest.predicate = NSPredicate(
			format: "id == %@", note.id as CVarArg
		)

		do {
			let results = try context.fetch(fetchRequest)
			if let notes = results as? [NoteData], let existingNote = notes.first {
				existingNote.title = note.title
				existingNote.body = note.body
			}
			else {
				let newNote = NoteData(context: context)
				newNote.id = note.id
				newNote.title = note.title
				newNote.body = note.body
			}
		} catch {
			fatalError("Unresolved error \(error)")
		}

		self.saveContext()
	}

	func getNoteBy(id: UUID, completion: @escaping (NotesListEntity?) -> Void) {
		let fetchRequest = Note.fetchRequest()
		fetchRequest.predicate = NSPredicate(
			format: "id == %@", id as CVarArg
		)

		do {
			let results = try context.fetch(fetchRequest)
			if let notes = results as? [NoteData], let note = notes.first {
				guard let id = note.id else { return completion(nil) }
				let result = NotesListEntity(id: id,
											 title: note.title,
											 body: note.body)
				completion(result)
			}
		} catch {
			fatalError("Unresolved error \(error)")
		}
	}

	func loadNotes(completion: @escaping ([NotesListEntity]) -> Void) {
		let request = NoteData.fetchRequest()
		do {
			var notesList: [NotesListEntity] = []
			let entities = try context.fetch(request)
			entities.forEach { entity in
				guard let id = entity.id else { return }
				let title = entity.title
				let body = entity.body
				notesList.append(NotesListEntity(id: id, title: title, body: body))
			}
			completion(notesList)
		} catch {
			fatalError("Unresolved error \(error)")
		}
	}
}
