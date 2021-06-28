//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        // navigation
        NavigationView {
            // form
            Form {
                // switch color scheme
                Section (header: Text("Color Scheme")) {
                    Picker(selection: .constant("Dark"), label: Text("")) {
                        Text("Dark")
                        Text("Light")
                        Text("System")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // app version
                Section (header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("2.2.1")
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
