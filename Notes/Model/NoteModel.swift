//

import Foundation
import SwiftUI

struct NoteModel {
    var id: UUID?
    let createdDate: Date
    var updatedDate: Date
    var title: String
    var descriptionNote: String
    var color: Color
    var favorite: Bool
    var locked: Bool
//    var image: Image
}
