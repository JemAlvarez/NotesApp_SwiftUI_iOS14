//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(sortDescriptors: [])
    var notes: FetchedResults<Note>
    
    var body: some View {
        NavigationView {
            List {
                TextField("Search", text: .constant(""))
                    .background(Color(colorScheme == .dark ? .systemGray6 : .white))
                
                // TEMPP
                NavigationLink(destination: NoteView()) {
                    Text("TEMP")
                }
                
                ForEach (notes) { note in
                    NavigationLink(destination: NoteView()) {
                        HStack {
                            Text(note.title ?? "Untitled")
                            Spacer()
                            Circle()
//                                .foregroundColor()
                                .frame(width: 15)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    print("Deleted ...")
                })
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationButtonsView())
            .navigationTitle("Notes\(notes.count != 0 ? ": \(notes.count)" : "")")
        }
    }
}

// navigation view buttons
struct NavigationButtonsView: View {
    var body: some View {
        // horizontal
        HStack {
            // menu
            Menu {
                // date ascending
                Button(action: {
                    print("Date Ascending ...")
                }) {
                    HStack {
                        Text("Date Ascending")
                        Image(systemName: "arrow.up.circle")
                    }
                }
                
                // date descending
                Button(action: {
                    print("Date Descending ...")
                }) {
                    HStack {
                        Text("Date Descending")
                        Image(systemName: "arrow.down.circle")
                    }
                }
                
                // title ascending
                Button(action: {
                    print("Title Ascending ...")
                }) {
                    HStack {
                        Text("Title Ascending")
                        Image(systemName: "arrow.up.circle")
                    }
                }
                
                // title descending
                Button(action: {
                    print("Title Descending ...")
                }) {
                    HStack {
                        Text("Title Descending")
                        Image(systemName: "arrow.down.circle")
                    }
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle")
            }
            
            // add note
            Button(action: {
                print("Adding Note ...")
            }) {
                Image(systemName: "note.text.badge.plus")
            }
        }
        .font(.title3)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
