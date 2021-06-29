//

import SwiftUI

struct ContentView: View {
    @State var colorScheme = UserDefaults.standard.string(forKey: "ColorScheme")
    
    var body: some View {
        MainTabView()
            .preferredColorScheme(colorScheme == "dark" ? .dark : (colorScheme == "light" ? .light : .none))
            .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) {_ in
                withAnimation {
                    colorScheme = UserDefaults.standard.string(forKey: "ColorScheme")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
