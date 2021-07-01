//

import SwiftUI
import SwifterSwift

struct NoteView: View {
    // env
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(sortDescriptors: [])
    var notes: FetchedResults<Note>
    @ObservedObject var noteViewModel = NoteViewModel()
    @State var note: NoteModel
    @State var coreNote: Note?
    @State var noteLocked = false
    
    var body: some View {
        // z
        ZStack {
            // form
            Form {
                // title
                Section(header: Text("Title")) {
                    TextField("Title", text: $note.title)
                        .background(Color(colorScheme == .dark ? .systemGray6 : .white))
                }
                
                // description
                Section(header: Text("Description")) {
                    TextEditor(text: $note.descriptionNote)
                        .background(Color(colorScheme == .dark ? .systemGray6 : .white))
                }
                
                // note settings
                Section(header: Text("Note settings")) {
                    // color picker
                    ColorPicker("Pick note color.", selection: $note.color)
                    
                    // favorite
                    Toggle("Favorite", isOn: $note.favorite)
                    
                    // locked
                    Toggle("Locked", isOn: $note.locked)
                }
                
                // dates
                Section(header: Text("Dates")) {
                    // created
                    HStack {
                        Text("Created Date")
                        Spacer()
                        Text(noteViewModel.onFormatText(note.createdDate))
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    
                    // updated
                    HStack {
                        Text("Updated Date")
                        Spacer()
                        Text(noteViewModel.onFormatText(note.updatedDate))
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                
                // save note
                Section(header: Text("Done")) {
                    // save
                    Button(action: {
                        noteViewModel.onAdd(note: note, coreNote: coreNote, notes: notes)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .bold()
                            .foregroundColor(.green)
                    }
                    
                    // delete
                    Button(action: {
                        noteViewModel.onDelete(note: note, notes: notes)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Delete")
                            .bold()
                            .foregroundColor(.red)
                    }
                }
            }
            .blur(radius: noteLocked ? 10 : 0) // if note locked blur
            .onReceive(Timer.publish(every: 30, on: .main, in: .common).autoconnect()) { time in
                if coreNote != nil {
                    note.updatedDate = Date()
                    noteViewModel.onEdit(noteModel: note, coreNote: coreNote!)
                }
            }
            
            // if note locked popup
            if noteLocked {
                LockedNoteView(locked: $noteLocked, color: note.color)
            }
        }
        .navigationTitle(noteLocked ? "" : (note.title == "" ? "Untitled" : note.title))
        .navigationBarItems(trailing:
            HStack {
                Circle().foregroundColor(Color(UIColor(hexString: UIColor(note.color).hexString, transparency: 1) ?? UIColor(note.color)))
                    .padding(.trailing)
                Button(action: {
                    noteViewModel.shareActionSheet(note)
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .font(.title3)
        )
        .onAppear {
            noteLocked = note.locked
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Constants.note, coreNote: nil)
    }
}
