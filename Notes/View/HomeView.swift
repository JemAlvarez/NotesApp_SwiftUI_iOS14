//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List {
                TextField("Search", text: .constant(""))
                    .background(Color(colorScheme == .dark ? .systemGray6 : .white))
                
                ForEach (0..<3) { i in
                    NavigationLink(destination: NoteView()) {
                        HStack {
                            Text("Note \(i)")
                            Spacer()
                            Circle()
                                .foregroundColor(.blue)
                                .frame(width: 15)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    print("Deleted ...")
                })
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationButtonsView())
            .navigationTitle("Notes: 15")
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