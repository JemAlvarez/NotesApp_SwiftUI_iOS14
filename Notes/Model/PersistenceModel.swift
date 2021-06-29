//

import Foundation
import CoreData

struct PersistenceModel {
    static let shared = PersistenceModel()
    
    let container: NSPersistentContainer
    
    // init
    init() {
        container = NSPersistentContainer(name: "NoteDataModel")
        
        container.loadPersistentStores { storeDesc, err in
            if let err = err as NSError? {
                print("Unresolved: \(err)")
            }
        }
    }
    
    // save data
    func onSaveContext() {
        do {
            try PersistenceModel.shared.container.viewContext.save()
        } catch {
            print("Error: \(error)")
        }
    }
    
    // add data
    func onAddNote(_ note: NoteModel) {
        let newNote = Note(context: PersistenceModel.shared.container.viewContext)
        newNote.id = UUID()
        newNote.createdDate = note.createdDate
        newNote.updatedDate = note.updatedDate
        newNote.title = note.title
        newNote.descriptionNote = note.descriptionNote
        newNote.favorite = note.favorite
        newNote.color = "\(note.color.cgColor?.components![0] ?? 0), \(note.color.cgColor?.components![0] ?? 0), \(note.color.cgColor?.components![2] ?? 0)"
        newNote.locked = note.locked
        onSaveContext()
    }
    
    // delete data
    func onDelete(_ item: Note) {
        PersistenceModel.shared.container.viewContext.delete(item)
        onSaveContext()
    }
    
    // edit data
    func onEditNote(noteCore: Note, noteModel: NoteModel) {
        noteCore.updatedDate = noteModel.updatedDate
        noteCore.title = noteModel.title
        noteCore.descriptionNote = noteModel.descriptionNote
        noteCore.favorite = noteModel.favorite
        noteCore.color = noteModel.color.description
        noteCore.locked = noteModel.locked
        
        onSaveContext()
    }
}
