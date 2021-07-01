//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    // on delete
    func onDelete(notes: FetchedResults<Note>, offsets: IndexSet) {
        offsets.map {notes[$0]}.forEach(PersistenceModel.shared.onDelete)
    }
    
    // get all images
    func getImage(_ images: [NoteImage]) -> [Image] {
        var newImages: [Image] = []
        
        for image in images {
            newImages.append(Image(uiImage: PersistenceModel.shared.dataToImage(image.image!)))
        }
        
        return newImages
    }
}
