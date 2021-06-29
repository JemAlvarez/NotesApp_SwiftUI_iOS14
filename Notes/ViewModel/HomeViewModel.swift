//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    // on sort
    // on delete
    func onDelete(notes: FetchedResults<Note>, offsets: IndexSet) {
        offsets.map {notes[$0]}.forEach(PersistenceModel.shared.onDelete)
    }
    
    // get rhb from desc
    func getColor (_ color: String) -> Color {
        let rgb = color.components(separatedBy: ", ")
        return Color(.displayP3, red: Double(rgb[0]) ?? 0, green: Double(rgb[1]) ?? 0, blue: Double(rgb[2]) ?? 0, opacity: 1)
    }
}
