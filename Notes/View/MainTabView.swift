//

import SwiftUI

struct MainTabView: View {
    @StateObject var tabViewModel = TabViewModel()
    
    var body: some View {
        // tab view
        TabView (selection: $tabViewModel.selectedTab) {
            // home tab
            HomeView()
                .tabItem {
                    Image(systemName: tabViewModel.selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            // settings tab
            SettingsView()
                .tabItem {
                    Image(systemName: tabViewModel.selectedTab == 1 ? "gearshape.2.fill" : "gearshape.2")
                }
                .tag(1)
        }
        .environmentObject(tabViewModel)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
