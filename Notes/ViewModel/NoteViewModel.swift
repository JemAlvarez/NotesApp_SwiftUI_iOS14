//

import Foundation
import SwiftUI

class NoteViewModel: ObservableObject {
    @Published var noteLocked = false
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage?
    @Published var selectedImage = 0
    @Published var uiImages: [UIImage] = []
    
    // load image
    func onLoadImage(_ save: Bool) -> Image? {
        guard let inputImage = inputImage else {return nil}
        if save {
            uiImages.append(inputImage)
        }
        return Image(uiImage: inputImage)
    }
    
    // remove image
    func removeImage(images: [Image], index: Int) -> [Image] {
        var newImages = images
        newImages.remove(at: index)
        uiImages.remove(at: index)
        return newImages
    }
    
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

    // share
    func shareActionSheet(_ note: NoteModel) {
        if !note.title.isEmpty || !note.descriptionNote.isEmpty {
            var items: [Any] = []
            
            if note.title.isEmpty {
                items = ["Untitled Note", note.descriptionNote]
            } else if note.descriptionNote.isEmpty {
                items = [note.title, "No note description"]
            } else {
                items = [note.title, note.descriptionNote]
            }
            
            if !uiImages.isEmpty {
                for image in uiImages {
                    items.append(image)
                }
            }
            
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true)
        }
    }
}
