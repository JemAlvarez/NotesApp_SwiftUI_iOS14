//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: [])
    var settings: FetchedResults<Settings>
    
    var body: some View {
        MainTabView()
            .onAppear {
                if settings.isEmpty {
                    let newSettings = Settings(context: PersistenceModel.shared.container.viewContext)
                    newSettings.colorScheme = "dark"
                    PersistenceModel.shared.onSaveContext()
                }
            }
            .preferredColorScheme(settings.isEmpty ? .dark : (settings[0].colorScheme == "dark" ? .dark : (settings[0].colorScheme == "light" ? .light : .none)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
