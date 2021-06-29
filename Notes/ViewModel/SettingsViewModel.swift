//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var colorScheme = UserDefaults.standard.string(forKey: "ColorScheme")
    @Published var version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String

    
    func changeColorScheme(color: String) {
        self.colorScheme = color
        UserDefaults.standard.set(color, forKey: "ColorScheme")
    }
}
