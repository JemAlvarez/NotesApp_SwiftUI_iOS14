//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var colorScheme = "dark"
    @Published var version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    
    func getColorScheme(_ object: Settings) {
        self.colorScheme = object.colorScheme ?? "dark"
    }
    
    func changeColorScheme(object: Settings, color: String) {
        self.colorScheme = color
        
        withAnimation {
            object.colorScheme = self.colorScheme
            PersistenceModel.shared.onSaveContext()
        }
    }
}
