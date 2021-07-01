//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    // on sort
    // on delete
    func onDelete(notes: FetchedResults<Note>, offsets: IndexSet) {
        offsets.map {notes[$0]}.forEach(PersistenceModel.shared.onDelete)
    }
}
