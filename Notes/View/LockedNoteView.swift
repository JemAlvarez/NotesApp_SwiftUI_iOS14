//

import SwiftUI

// locked note view popup
struct LockedNoteView: View {
    @Binding var locked: Bool
    var color: Color
    
    var body: some View {
        // z
        ZStack {
            // blur color
            color.edgesIgnoringSafeArea(.all).opacity(0.8)
            
            // v
            VStack {
                Text("Note is Locked!")
                    .padding(.bottom)
                
                // button
                Button(action: {
                    locked = false
                }) {
                    Text("UNLOCK!")
                        .padding(10)
                        .background(Color(.systemGray4).opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.primary)
                }
            }
            .padding(30)
            .background(Color(.systemGray5).opacity(0.5))
            .cornerRadius(15)
        }
    }
}
