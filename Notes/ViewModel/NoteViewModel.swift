//

import Foundation
import SwiftUI

class NoteViewModel: ObservableObject {
    // add
    func onAdd(note: NoteModel, coreNote: Note?, notes: FetchedResults<Note>) {
        if coreNote == nil {
            PersistenceModel.shared.onAddNote(note)
        } else {
            let foundNote = onFindNote(notes: notes, note: note)
            
            if foundNote != nil {
                onEdit(noteModel: note, coreNote: foundNote!)
            }
        }
    }
    
    // edit
    func onEdit(noteModel: NoteModel, coreNote: Note) {
        coreNote.createdDate = noteModel.createdDate
        coreNote.updatedDate = noteModel.updatedDate
        coreNote.title = noteModel.title
        coreNote.descriptionNote = noteModel.descriptionNote
        coreNote.color = UIColor(noteModel.color).hexString
        coreNote.favorite = noteModel.favorite
        coreNote.locked = noteModel.locked
        PersistenceModel.shared.onSaveContext()
    }
    
    // on delete
    func onDelete(note: NoteModel, notes: FetchedResults<Note>) {
        let foundNote = onFindNote(notes: notes, note: note)
        
        if foundNote != nil {
            PersistenceModel.shared.onDelete(foundNote!)
        }
    }
    
    // format text
    func onFormatText (_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy - h:mm a"
        return formatter.string(from: date)
    }
    
    // find note
    func onFindNote(notes: FetchedResults<Note>, note: NoteModel) -> Note? {
        for coreNote in notes {
            if coreNote.id == note.id {
                return coreNote
            }
        }
        
        return nil
    }

    
    func shareActionSheet(_ note: NoteModel) {
        if !note.title.isEmpty || !note.descriptionNote.isEmpty {
            var items: [String] = []
            
            if note.title.isEmpty {
                items = ["Untitled Note", note.descriptionNote]
            } else {
                items = [note.title, "No note description"]
            }
            
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true)
        }
    }
}
