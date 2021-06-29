//

import SwiftUI

func shareActionSheet() {
    let items = ["Note"]
    let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true)
}

struct NoteView: View {
    // env
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        // z
        ZStack {
            // form
            Form {
                // title
                Section(header: Text("Title")) {
                    TextField("Title", text: .constant(""))
                        .background(Color(colorScheme == .dark ? .systemGray6 : .white))
                }
                
                // description
                Section(header: Text("Description")) {
                    TextEditor(text: .constant(""))
                        .background(Color(colorScheme == .dark ? .systemGray6 : .white))
                }
                
                // note settings
                Section(header: Text("Note settings")) {
                    // color picker
                    ColorPicker("Pick note color.", selection: .constant(.blue))
                    
                    // favorite
                    Toggle("Favorite", isOn: .constant(false))
                    
                    // locked
                    Toggle("Locked", isOn: .constant(true))
                }
                
                // dates
                Section(header: Text("Dates")) {
                    // created
                    HStack {
                        Text("Created Date")
                        Spacer()
                        Text("Aug 18, 2021 - 10:39 AM")
                            .foregroundColor(.secondary)
                    }
                    
                    // updated
                    HStack {
                        Text("Updated Date")
                        Spacer()
                        Text("Aug 18, 2021 - 10:39 AM")
                            .foregroundColor(.secondary)
                    }
                }
                
                // save note
                Section(header: Text("Save")) {
                    Button(action: {
                        print("Note saved ...")
                    }) {
                        Text("Done!")
                    }
                }
            }
            .blur(radius: 0) // if note locked blur
            
            // if note locked popup
//                LockedNoteView()
        }
        .navigationTitle("Untitled")
        .navigationBarItems(trailing:
            HStack {
                Circle().foregroundColor(Color(.sRGB, red: 0.994, green: 0.984, blue: 0.402, opacity: 1))
                    .padding(.trailing)
                Button(action: shareActionSheet) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .font(.title3)
        )
    }
}

// locked note view popup
struct LockedNoteView: View {
    var body: some View {
        // z
        ZStack {
            // blur color
            Color.blue.edgesIgnoringSafeArea(.all).opacity(0.8)
            
            // v
            VStack {
                Text("View is Locked!")
                    .padding(.bottom)
                
                // button
                Button(action: {
                    print("Unlocking...")
                }) {
                    Text("UNLOCK!")
                        .padding(10)
                        .background(Color(.systemGray4).opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.primary)
                }
            }
            .padding(30)
            .background(Color(.systemGray5).opacity(0.5))
            .cornerRadius(15)
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
