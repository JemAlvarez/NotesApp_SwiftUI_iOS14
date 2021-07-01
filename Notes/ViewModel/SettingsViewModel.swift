//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var colorScheme = UserDefaults.standard.string(forKey: "ColorScheme")
    @Published var version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String

    
    func changeColorScheme(color: String) {
        self.colorScheme = color
        UserDefaults.standard.set(color, forKey: "ColorScheme")
    }
    
    func setIcon(_ icon: String?) {
        UIApplication.shared.setAlternateIconName(icon) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
            }
        }
    }
    
    func resetAllSettings () {
        changeColorScheme(color: "system")
        setIcon(nil)
    }
}
