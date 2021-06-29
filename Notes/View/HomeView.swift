//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel = HomeViewModel()
    @FetchRequest(sortDescriptors: [])
    var notes: FetchedResults<Note>
    @State var filter = ""
    @State var sorting: [NSSortDescriptor] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $filter)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)

                CustomListView(filter: filter.isEmpty ? nil : filter, sorting: sorting, homeViewModel: homeViewModel)
            }
            .navigationBarItems(leading: EditButton(), trailing: NavigationButtonsView(sorting: $sorting))
            .navigationTitle("Notes\(notes.count != 0 ? ": \(notes.count)" : "")")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
