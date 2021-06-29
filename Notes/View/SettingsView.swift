//

import SwiftUI

struct SettingsView: View {
    @FetchRequest(sortDescriptors: [])
    var settings: FetchedResults<Settings>
    @ObservedObject var viewModel = SettingsViewModel()
    
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
                            viewModel.changeColorScheme(object: settings[0], color: "dark")
                        }) {
                            Text("Dark")
                        }
                        
                        // light mode
                        Button(action: {
                            viewModel.changeColorScheme(object: settings[0], color: "light")
                        }) {
                            Text("Light")
                        }
                        
                        // system
                        Button(action: {
                            viewModel.changeColorScheme(object: settings[0], color: "system")
                        }) {
                            Text("System")
                        }
                    } label: {
                        HStack {
                            Text("Selected app color scheme")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(viewModel.colorScheme.capitalized)
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
        .onAppear {
            viewModel.getColorScheme(settings[0])
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
