//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    @EnvironmentObject var tabViewModel: TabViewModel
    
    var body: some View {
        // navigation
        NavigationView {
            // form
            Form {
                // switch color scheme
                Section (header: Text("Color Scheme")) {
                    Menu {
                        // dark mode
                        Button(action: {
                            viewModel.changeColorScheme(color: "dark")
                            tabViewModel.selectedTab = 1
                        }) {
                            Text("Dark")
                        }
                        
                        // light mode
                        Button(action: {
                            viewModel.changeColorScheme(color: "light")
                            tabViewModel.selectedTab = 1
                        }) {
                            Text("Light")
                        }
                        
                        // system
                        Button(action: {
                            viewModel.changeColorScheme(color: "system")
                            tabViewModel.selectedTab = 1
                        }) {
                            Text("System")
                        }
                    } label: {
                        HStack {
                            Text("Selected app color scheme")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(viewModel.colorScheme?.capitalized ?? "System")
                        }
                    }
                }
                
                // app version
                Section (header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(viewModel.version ?? "")
                    }
                }
                
                // reset app settings
                Section {
                    Button(action: {
                        print("Settings Reseted!")
                    }) {
                        Text("Reset All Settings")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
