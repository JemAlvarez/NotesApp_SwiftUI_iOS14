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
                Picker(selection: $selected, label: Text("SORTING")) {
                    Label("Created Date", systemImage: "arrow.up.circle").tag(0)
                    Label("Created Date", systemImage: "arrow.down.circle").tag(1)
                    Label("Update Date", systemImage: "arrow.up.circle").tag(2)
                    Label("Update Date", systemImage: "arrow.down.circle").tag(3)
                    Label("Title", systemImage: "arrow.up.circle").tag(4)
                    Label("Title", systemImage: "arrow.down.circle").tag(5)
                    Label("Favorite", systemImage: "arrow.up.circle").tag(6)
                    Label("Favorite", systemImage: "arrow.down.circle").tag(7)
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle")
            }
            
            NavigationLink(destination: NoteView(note: Constants.note, coreNote: nil)) {
                Image(systemName: "note.text.badge.plus")
            }
        }
        .font(.title3)
        .onChange(of: selected) { newVal in
            withAnimation {
                switch newVal {
                case 0:
                    sorting = [NSSortDescriptor(keyPath: \Note.createdDate, ascending: true)]
                case 1:
                    sorting = [NSSortDescriptor(keyPath: \Note.createdDate, ascending: false)]
                case 2:
                    sorting = [NSSortDescriptor(keyPath: \Note.updatedDate, ascending: true)]
                case 3:
                    sorting = [NSSortDescriptor(keyPath: \Note.updatedDate, ascending: false)]
                case 4:
                    sorting = [NSSortDescriptor(keyPath: \Note.title, ascending: true)]
                case 5:
                    sorting = [NSSortDescriptor(keyPath: \Note.title, ascending: false)]
                case 6:
                    sorting = [NSSortDescriptor(keyPath: \Note.favorite, ascending: true)]
                case 7:
                    sorting = [NSSortDescriptor(keyPath: \Note.favorite, ascending: false)]
                default:
                    sorting = [NSSortDescriptor(keyPath: \Note.createdDate, ascending: true)]
                }
            }
        }
    }
}
