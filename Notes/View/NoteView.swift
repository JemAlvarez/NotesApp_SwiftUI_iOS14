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
                
                // image
                Section(header: Text("Images")) {
                    if note.images != nil {
                        if note.images!.count != 0 {
                            VStack {
                                Text("\(note.images!.count) Image\(note.images!.count == 1 ? "" : "s")")
                                    .foregroundColor(.secondary)
                                
                                TabView (selection: $noteViewModel.selectedImage) {
                                    ForEach(0..<note.images!.count, id: \.self) { i in
                                        VStack {
                                            note.images![i]
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 140)
                                                .padding(.vertical)
                                                .cornerRadius(10)
                                                .tag(i)
                                            
                                            Button(action: {
                                                note.images = noteViewModel.removeImage(images: note.images!, index: i)
                                            }) {
                                                Label("Delete Image", systemImage: "trash.circle.fill")
                                            }
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(Color.red)
                                            .cornerRadius(10)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                .frame(height: 250)
                            }
                        }
                    }
                    
                    Button(action: {
                        noteViewModel.showingImagePicker = true
                    }) {
                        Label("Add Image", systemImage: "photo.on.rectangle.angled")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
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
            .blur(radius: noteViewModel.noteLocked ? 10 : 0) // if note locked blur
            .onReceive(Timer.publish(every: 30, on: .main, in: .common).autoconnect()) { time in
                if coreNote != nil {
                    note.updatedDate = Date()
                    noteViewModel.onEdit(noteModel: note, coreNote: coreNote!)
                }
            }
            // image picker sheet
            .sheet(isPresented: $noteViewModel.showingImagePicker, onDismiss: {
                // if loaded image is not nil
                if noteViewModel.onLoadImage() != nil {
                    // if theres no images array
                    if note.images == nil {
                        note.images = [] // create new array and add
                        note.images!.append(noteViewModel.onLoadImage()!)
                    } else { // if theres is image array
                        note.images!.append(noteViewModel.onLoadImage()!)
                    }
                }
            }) {
                ImagePickerView(image: $noteViewModel.inputImage)
            }
            
            // if note locked popup
            if noteViewModel.noteLocked {
                LockedNoteView(locked: $noteViewModel.noteLocked, color: note.color)
            }
        }
        .navigationTitle(noteViewModel.noteLocked ? "" : (note.title == "" ? "Untitled" : note.title))
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
            noteViewModel.noteLocked = note.locked
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Constants.note, coreNote: nil)
    }
}
