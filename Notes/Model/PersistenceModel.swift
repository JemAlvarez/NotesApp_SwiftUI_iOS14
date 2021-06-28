//

import Foundation
import CoreData

struct PersistenceModel {
    static let shared = PersistenceModel()
    
    let container: NSPersistentContainer
    
    // init
    init() {
        container = NSPersistentContainer(name: "Notes")
        
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
        newNote.createdDate = note.createdDate
        newNote.updatedDate = note.updatedDate
        newNote.title = note.title
        newNote.descriptionNote = note.descriptionNote
        newNote.favorite = note.favorite
        newNote.color = note.color
        newNote.locked = note.locked
        
        onSaveContext()
    }
    
    // delete data
    func onDelete(_ note: Note) {
        PersistenceModel.shared.container.viewContext.delete(note)
        onSaveContext()
    }
    
    // edit data
    func onEdit(noteCore: Note, noteModel: NoteModel) {
        noteCore.updatedDate = noteModel.updatedDate
        noteCore.title = noteModel.title
        noteCore.descriptionNote = noteModel.descriptionNote
        noteCore.favorite = noteModel.favorite
        noteCore.color = noteModel.color
        noteCore.locked = noteModel.locked
        
        onSaveContext()
    }
}
