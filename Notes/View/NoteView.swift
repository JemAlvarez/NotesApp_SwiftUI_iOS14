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
    
    @State var runOnDisappear = true
    
    var body: some View {
        // z
        ZStack {
            VStack {
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
                        if noteViewModel.uiImages.count != 0 {
                            VStack {
                                Text("\(noteViewModel.uiImages.count) Image\(noteViewModel.uiImages.count == 1 ? "" : "s") \(noteViewModel.uiImages.count == 5 ? "(MAX)" : "")")
                                    .foregroundColor(.secondary)
                                
                                TabView (selection: $noteViewModel.selectedImage) {
                                    ForEach(0..<noteViewModel.uiImages.count, id: \.self) { i in
                                        VStack {
                                            Image(uiImage: noteViewModel.uiImages[i])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 140)
                                                .padding(.vertical)
                                                .cornerRadius(10)
                                                .tag(i)
                                                .contextMenu(
                                                    ContextMenu {
                                                        Text("Nothing to see here 😉")
                                                    }
                                                )
                                            
                                            Button(action: {
                                                noteViewModel.removeImage(index: i)
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
                }
                .sheet(isPresented: $noteViewModel.showingImagePicker, onDismiss: noteViewModel.onLoadImage) {
                    ImagePickerView(image: $noteViewModel.inputImage)
                }
                
                // done
                HStack (spacing: 15) {
                    // delete
                    Button(action: {
                        runOnDisappear = false
                        noteViewModel.onDelete(note: note, notes: notes)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Delete")
                            .bold()
                            .foregroundColor(.red)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(colorScheme == .dark ? .systemGray6 : .systemGray5))
                    .cornerRadius(10)
                    
                    // save
                    Button(action: {
                        runOnDisappear = false
                        noteViewModel.onAdd(note: note, coreNote: coreNote)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding()
            }
            .blur(radius: noteViewModel.noteLocked ? 10 : 0) // if note locked bluR
            
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
            
            noteViewModel.uiImages = []
            
            if coreNote != nil {
                for image in coreNote!.imagesArray {
                    noteViewModel.uiImages.append(UIImage(data: image.image!)!)
                }
            }
        }
        .onDisappear {
            if runOnDisappear {
                if coreNote != nil {
                    note.updatedDate = Date()
                    noteViewModel.onEdit(noteModel: note, coreNote: coreNote!)
                }
            }
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Constants.note, coreNote: nil)
    }
}
