import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                AuthenticatedView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                }
            }
        } else {
            self.isUnlocked = true // Ideally, we would have a password here if biometrics are unavailable
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
