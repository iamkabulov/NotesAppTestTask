//
//  Notes+CoreData.swift
//  NotesAppTestTask
//
//  Created by Nursultan Kabulov on 31.01.2024.
//

import Foundation
import CoreData

protocol INotesCoreData: AnyObject
{
	func saveNote(_ note: NotesListEntity)
	func getNoteBy(id: UUID, completion: @escaping (NotesListEntity?) -> Void)
	func loadNotes(completion: @escaping ([NotesListEntity]) -> Void)
	func deleteNote(id: UUID)
}
public class Note: NSManagedObject
{

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

public class NotesCoreData
{
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
}

//MARK: - INotesCoreData
extension NotesCoreData: INotesCoreData {
	func saveContext() {
		do {
			try context.save()
		} catch {
			fatalError("Unresolved saving error \(error)")
		}
	}

	func deleteNote(id: UUID) {
		if let note = self.fetchById(id) {
			context.delete(note)
		}
		saveContext()
	}

	func saveNote(_ note: NotesListEntity) {
		if let fetchedNote = self.fetchById(note.id) {
			fetchedNote.title = note.title
			fetchedNote.body = note.body
			fetchedNote.date = note.date
		} else {
			let newNote = NoteData(context: context)
			newNote.id = note.id
			newNote.title = note.title
			newNote.body = note.body
			newNote.date = note.date
		}
		saveContext()
	}

	func getNoteBy(id: UUID, completion: @escaping (NotesListEntity?) -> Void) {
		if let fetchedNote = self.fetchById(id) {
			let result = NotesListEntity(id: id,
										 title: fetchedNote.title,
										 body: fetchedNote.body,
										 date: Date.now)
			completion(result)
		}
		return completion(nil)
	}

	func loadNotes(completion: @escaping ([NotesListEntity]) -> Void) {
		let request = NoteData.fetchRequest()
		do {
			var notesList: [NotesListEntity] = []
			let entities = try context.fetch(request)
			entities.forEach { entity in
				guard let id = entity.id,
				let date = entity.date else { return }
				let title = entity.title
				let body = entity.body
				notesList.append(NotesListEntity(id: id, title: title, body: body, date: date))
			}
			completion(notesList)
		} catch {
			fatalError("Unresolved fetching all notes error \(error)")
		}
	}

	private func fetchById(_ id: UUID) -> NoteData? {
		let fetchRequest = Note.fetchRequest()
		fetchRequest.predicate = NSPredicate(
			format: "id == %@", id as CVarArg
		)

		do {
			let results = try context.fetch(fetchRequest)
			if let note = results.first {
				return note
			}
		} catch {
			fatalError("Unresolved fetching note error \(error)")
		}
		return nil
	}
}
