import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating > 1 ? .primary : .red)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
                
                Text("Count: \(books.count)")
                    .sheet(isPresented: $showingAddScreen) {
                        AddBookView().environment(\.managedObjectContext, self.moc)
                }
            }
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
            .navigationBarTitle("Bookworm")
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 @State private var rememberMe = false
 
 var body: some View {
     VStack {
         PushButton(title: "Remember Me", isOn: $rememberMe)
         Text(rememberMe ? "On" : "Off")
     }
 }
 */

/*
 @Environment(\.horizontalSizeClass) var sizeClass
 
 var body: some View {
     if sizeClass == .compact {
         return AnyView(VStack {
             Text("Active size class:")
             Text("COMPACT")
         }
         .font(.largeTitle))
     } else {
         return AnyView(HStack {
             Text("Active size class:")
             Text("REGULAR")
         }
         .font(.largeTitle))
     }
 }
 */

/*
 @Environment(\.managedObjectContext) var moc
 @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>

 var body: some View {
     VStack {
         List {
             ForEach(students, id: \.id) { student in
                 Text(student.name ?? "Unknown")
             }
         }
         
         Button("Add") {
             let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
             let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

             let chosenFirstName = firstNames.randomElement()!
             let chosenLastName = lastNames.randomElement()!

             let student = Student(context: self.moc)
             student.id = UUID()
             student.name = "\(chosenFirstName) \(chosenLastName)"
             try? self.moc.save()
         }
     }
 }
 */

/*
 struct PushButton: View {
     let title: String
     @Binding var isOn: Bool
     
     var onColors = [Color.red, Color.yellow]
     var offColors = [Color(white: 0.6), Color(white: 0.4)]
     
     var body: some View {
         Button(title) {
             self.isOn.toggle()
         }
         .padding()
         .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
         .foregroundColor(.white)
         .clipShape(Capsule())
         .shadow(radius: isOn ? 0 : 5)
     }
 }


 */
