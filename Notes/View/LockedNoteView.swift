//

import SwiftUI
import LocalAuthentication

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
                    authenticate()
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
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        // authenticated successfully
                        withAnimation {
                            locked = false
                        }
                    } else {
                        // there was a problem
                        print("ERROR")
                    }
                }
            }
        } else {
            // no biometrics
            print("NO BIOMETRICS")
        }
    }
}
