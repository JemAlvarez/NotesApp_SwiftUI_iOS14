//

import Foundation
import SwiftUI
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
    func onAddNote(_ note: NoteModel, images: [UIImage]) {
        let newNote = Note(context: PersistenceModel.shared.container.viewContext)
        newNote.id = UUID()
        newNote.createdDate = note.createdDate
        newNote.updatedDate = note.updatedDate
        newNote.title = note.title
        newNote.descriptionNote = note.descriptionNote
        newNote.favorite = note.favorite
        newNote.color = UIColor(note.color).hexString
        newNote.locked = note.locked
        
        for image in images {
            let newImage = NoteImage(context: PersistenceModel.shared.container.viewContext)
            newImage.image = imageToData(image)
            newImage.note = newNote
        }
        
        onSaveContext()
    }
    
    // delete data
    func onDelete(_ item: NSManagedObject) {
        PersistenceModel.shared.container.viewContext.delete(item)
        onSaveContext()
    }
    
    // convert image to data
    func imageToData(_ image: UIImage) -> Data {
        return image.jpegData(compressionQuality: 1)!
    }
    
    // convert data to image
    func dataToImage(_ data: Data) -> UIImage {
        return UIImage(data: data)!
    }
}
