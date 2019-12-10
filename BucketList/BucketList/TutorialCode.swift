/*
 struct LoadingView: View {
     var body: some View {
         Text("Loading...")
     }
 }

 struct SuccessView: View {
     var body: some View {
         Text("Success!")
     }
 }

 struct FailedView: View {
     var body: some View {
         Text("Failed.")
     }
 }

 struct ContentView: View {
     @State private var loadingState = LoadingState.loading
     
     enum LoadingState {
         case loading, success, failed
     }
     
     var body: some View {
         Group {
             if loadingState == .loading {
                 LoadingView()
             } else if loadingState == .success {
                 SuccessView()
             } else if loadingState == .failed {
                 FailedView()
             }
             Button("Change State") {
                 if self.loadingState == .loading {
                     self.loadingState = .success
                 } else if self.loadingState == .success {
                     self.loadingState = .failed
                 } else if self.loadingState == .failed {
                     self.loadingState = .loading
                 }
             }
         }
     }
 }

 extension FileManager {
     static var documentsDirectory: URL {
         FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     }
     
     static func save(_ str: String, to url: URL) {
         do {
             try str.write(to: url, atomically: true, encoding: .utf8)
             let input = try String(contentsOf: url)
             print(input)
         } catch {
             print(error.localizedDescription)
         }
     }
 }

 */
/*
 struct ContentView: View {
     var loadingState = LoadingState.loading
     
     enum LoadingState {
         case loading, success, failed
     }
     
     var body: some View {
         Text("Hello World")
         .onTapGesture {
             let str = "Test Message"
             let url = FileManager.documentsDirectory.appendingPathComponent("message.txt")

             FileManager.save(str, to: url)
         }
     }
     
 }

 extension FileManager {
     static var documentsDirectory: URL {
         FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
     }
     
     static func save(_ str: String, to url: URL) {
         do {
             try str.write(to: url, atomically: true, encoding: .utf8)
             let input = try String(contentsOf: url)
             print(input)
         } catch {
             print(error.localizedDescription)
         }
     }
 }
 */
/*
 struct ContentView: View {
     @State private var isUnlocked = false
     
     var body: some View {
         VStack {
             if self.isUnlocked {
                 Text("Unlocked")
             } else {
                 Text("Locked")
             }
         }
         .onAppear(perform: authenticate)
     }
     
     func authenticate() {
         let context = LAContext()
         var error: NSError?
         
         if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
             let reason = "We need to unlock your data."
             context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                 DispatchQueue.main.async {
                     if success {
                         self.isUnlocked = true
                     } else {
                         
                     }
                 }
             }
         }
     }
 }
 */
