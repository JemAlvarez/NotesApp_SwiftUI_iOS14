//

import SwiftUI

struct NavigationButtonsView: View {
    @Binding var sorting: [NSSortDescriptor]
    
    @State var selected = 2
    
    var body: some View {
        // horizontal
        HStack {
            // menu
            Menu {
                // created date ascending
                Button(action: {
                    sorting = [NSSortDescriptor(keyPath: \Note.createdDate, ascending: true)]
                    selected = 0
                }) {
                    HStack {
                        Text("Created Date")
                        if selected == 0 {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "arrow.up.circle")
                        }
                    }
                }
                
                // created date descending
                Button(action: {
                    sorting = [NSSortDescriptor(keyPath: \Note.createdDate, ascending: false)]
                    selected = 1
                }) {
                    HStack {
                        Text("Created Date")
                        if selected == 1 {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "arrow.down.circle")
                        }
                    }
                }
                
                // updated date ascending
                Button(action: {
                    sorting = [NSSortDescriptor(keyPath: \Note.updatedDate, ascending: true)]
                    selected = 2
                }) {
                    HStack {
                        Text("Updated Date")
                        if selected == 2 {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "arrow.up.circle")
                        }
                    }
                }
                
                // updated date descending
                Button(action: {
                    sorting = [NSSortDescriptor(keyPath: \Note.updatedDate, ascending: false)]
                    selected = 3
                }) {
                    HStack {
                        Text("Updated Date")
                        if selected == 3 {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "arrow.down.circle")
                        }
                    }
                }
                
                // title ascending
                Button(action: {
                    sorting = [NSSortDescriptor(keyPath: \Note.title, ascending: true)]
                    selected = 4
                }) {
                    HStack {
                        Text("Title")
                        if selected == 4 {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "arrow.up.circle")
                        }
                    }
                }
                
                // title descending
                Button(action: {
                    sorting = [NSSortDescriptor(keyPath: \Note.title, ascending: false)]
                    selected = 5
                }) {
                    HStack {
                        Text("Title")
                        if selected == 5 {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "arrow.down.circle")
                        }
                    }
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle")
            }
            
            NavigationLink(destination: NoteView(note: Constants.note, coreNote: nil)) {
                Image(systemName: "note.text.badge.plus")
            }
        }
        .font(.title3)
    }
}
