/*
 struct User: Identifiable {
     var id = "Taylor Swift"
 }

 struct ContentView: View {
     @State private var selectedUser: User? = nil
     
     var body: some View {
         Text("Hello, World!")
             .onTapGesture {
                 self.selectedUser = User()
             }
             .alert(item: $selectedUser) { user in
                 Alert(title: Text(user.id))
             }
     }
 }
 */

/*
 struct ContentView: View {
     @State var layoutVertically = false

     var body: some View {
         Group {
             if layoutVertically {
                 VStack {
                     UserView()
                 }
             } else {
                 HStack {
                     UserView()
                 }
             }
         }
         .onTapGesture {
             self.layoutVertically.toggle()
         }
     }
 }
 
 struct UserView: View {
    var body: some View {
        Text("Name: Paul")
        Text("Country: England")
        Text("Pets: Luna, Arya, and Toby")
    }
 }
 
 struct ContentView: View {
     @Environment(\.horizontalSizeClass) var sizeClass

     var body: some View {
         Group {
             if sizeClass == .compact {
                 VStack {
                     UserView()
                 }
             } else {
                 HStack {
                     UserView()
                 }
             }
         }
     }
 }
 
 struct ContentView: View {
     @Environment(\.horizontalSizeClass) var sizeClass

     var body: some View {
         Group {
             if sizeClass == .compact {
                 VStack(content: UserView.init)
             } else {
                 HStack(content: UserView.init)
             }
         }
     }
 }

 */

