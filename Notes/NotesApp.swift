//

import SwiftUI

@main
struct NotesApp: App {
    let vc = PersistenceModel.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, vc)
        }
    }
}
