//

import SwiftUI
import CoreData

struct CustomListView: View {
    var fetchRequest: FetchRequest<Note>
    var notes: FetchedResults<Note> {
        fetchRequest.wrappedValue
    }
    var homeViewModel: HomeViewModel
    
    var body: some View {
        List() {
            ForEach(notes) { note in
                NavigationLink(destination:
                                NoteView(note:
                                            NoteModel(id: note.id, createdDate: note.createdDate ?? Date(), updatedDate: note.updatedDate ?? Date(), title: note.title ?? "", descriptionNote: note.descriptionNote ?? "", color: Color(UIColor(hexString: note.color ?? "") ?? .white), favorite: note.favorite, locked: note.locked),
                                         coreNote: note)
                ) {
                    HStack {
                        Text(note.title ?? "" == "" ? "Untitled": note.title!)
                        Spacer()
                        if note.favorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        if note.locked {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.red)
                        }
                        Circle()
                            .foregroundColor(Color(UIColor(hexString: note.color ?? "") ?? .white))
                            .frame(width: 15)
                    }
                    .contextMenu(
                        ContextMenu {
                            Text(note.descriptionNote == "" ? "No description..." : ("Description: \(note.descriptionNote ?? "")"))
                        }
                    )
                }
            }
            .onDelete(perform: { indexSet in homeViewModel.onDelete(notes: notes, offsets: indexSet)})
//            .onAppear {
//                for note in notes {
//                    print("NOTE", note.imagesArray)
//                }
//            }
        }
    }
    
    init(filter: String?, sorting: [NSSortDescriptor], homeViewModel: HomeViewModel) {
        fetchRequest = FetchRequest<Note>(entity: Note.entity(), sortDescriptors: sorting, predicate: filter == nil ? nil : NSPredicate(format: "title BEGINSWITH %@", filter!))
        self.homeViewModel = homeViewModel
    }
}
