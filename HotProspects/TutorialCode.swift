/*
 class User: ObservableObject {
     @Published var name = "Jimi Hendrix"
 }

 struct ContentView: View {
     let user = User()
     
     var body: some View {
         VStack {
             EditView()
             DisplayView()
         }
         .environmentObject(user)
     }
 }

 struct EditView: View {
     @EnvironmentObject var user: User
     
     var body: some View {
         TextField("Name", text: $user.name)
     }
 }

 struct DisplayView: View {
     @EnvironmentObject var user: User
     
     var body: some View {
         Text(user.name)
     }
 */
