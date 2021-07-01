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
                Section (header: Text("App Appearance")) {
                    
                    // color scheme
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
                            Text("Color Scheme")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(viewModel.colorScheme?.capitalized ?? "System")
                        }
                    }
                }
                
                // app icon
                Section {
                    Text("App Icon")
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image("default_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .cornerRadius(10)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.setIcon(nil)
                        }) {
                            Text("Default")
                        }
                    }
                    
                    HStack {
                        Image("dark_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .cornerRadius(10)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.setIcon("Dark")
                        }) {
                            Text("Dark")
                        }
                    }
                }
                .padding(.vertical, 15)
                
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
                        viewModel.resetAllSettings()
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
