//

import Foundation

struct NoteModel: Identifiable {
    let id = UUID()
    let createdDate: Date
    var updatedDate: Date
    var title: String
    var descriptionNote: String
    var color: String
    var favorite: Bool
    var locked: Bool
//    var image: Image
}
