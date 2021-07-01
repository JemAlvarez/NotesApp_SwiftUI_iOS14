//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var color: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var descriptionNote: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var locked: Bool
    @NSManaged public var title: String?
    @NSManaged public var updatedDate: Date?
    @NSManaged public var image: NSSet?
    
    public var imagesArray: [NoteImage] {
        let set = image as? Set<NoteImage> ?? []
        
        return Array(set)
    }

}

// MARK: Generated accessors for image
extension Note {

    @objc(addImageObject:)
    @NSManaged public func addToImage(_ value: NoteImage)

    @objc(removeImageObject:)
    @NSManaged public func removeFromImage(_ value: NoteImage)

    @objc(addImage:)
    @NSManaged public func addToImage(_ values: NSSet)

    @objc(removeImage:)
    @NSManaged public func removeFromImage(_ values: NSSet)

}

extension Note : Identifiable {

}
