//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            NavigationLink(destination: SortView()) {
                Text("Sort")
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            }
            
            ForEach(0..<7, id: \.self) { _ in
                NoteListView()
            }
        }
        .navigationTitle("Notes: 7")
    }
}

struct SortView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "calendar.badge.plus")
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "calendar.badge.clock")
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "star")
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "textformat")
            }
        }
    }
}

struct NoteListView: View {
    var body: some View {
        NavigationLink(destination: NoteView()) {
            HStack {
                Text("Title")
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Image(systemName: "lock.fill")
                    .foregroundColor(.red)
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct NoteView: View {
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                Text("Note title")
            }
            
            Section(header: Text("Description")) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nulla nisl, imperdiet ut tristique at, faucibus et odio. Nullam blandit, odio id malesuada ultricies, augue lectus gravida metus, ac volutpat ante tortor ac tortor. Maecenas viverra enim in ex malesuada, ut iaculis velit rhoncus. Nam sagittis tellus quis scelerisque viverra.")
            }
            
            Section(header: Text("Images")) {
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        Image("placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 100)
                        
                        Image("placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 100)
                        
                        Image("placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 100)
                    }
                }
            }
            .padding(.vertical)
            
            Section(header: Text("Note Settings")) {
                HStack {
                    Text("Note Color")
                    Spacer()
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
                
                Toggle("Favorite", isOn: .constant(false))
                
                Toggle("Locked", isOn: .constant(true))
            }
            
            Section(header: Text("Dates")) {
                VStack {
                    Text("Created")
                    Text("Fri, 07/02/21 - 10:58 PM")
                        .font(.caption2)
                }
                
                VStack {
                    Text("Updated")
                    Text("Fri, 07/02/21 - 10:58 PM")
                        .font(.caption2)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
