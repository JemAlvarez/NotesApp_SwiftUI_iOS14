//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        // tab view
        TabView {
            // home tab
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            // settings tab
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
