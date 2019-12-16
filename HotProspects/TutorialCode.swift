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

/*
 struct ContentView: View {
     @State private var selectedTab = 0

     var body: some View {
         TabView(selection: $selectedTab) {
             Text("Tab 1")
                 .onTapGesture {
                     self.selectedTab = 1
                 }
                 .tabItem {
                     Image(systemName: "star")
                     Text("One")
                 }
                 .tag(0)

             Text("Tab 2")
                 .onTapGesture {
                     self.selectedTab = 0
                 }
                 .tabItem {
                     Image(systemName: "star.fill")
                     Text("Two")
                 }
                 .tag(1)
         }
     }
 }
 */

/*
 
 class DelayedUpdater: ObservableObject {
     @Published var value = 0
 
     var value = 0 {
         willSet {
             objectWillChange.send()
         }
     }

     init() {
         for i in 1...10 {
             DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                 self.value += 1
             }
         }
     }
 }
 
 struct ContentView: View {
     @ObservedObject var updater = DelayedUpdater()

     var body: some View {
         Text("Value is: \(updater.value)")
     }
 }
 */

/*
 enum NetworkError: Error {
     case badURL, requestFailed, unknown
 }

 struct ContentView: View {
     var body: some View {
         Text("Hello, World!")
             .onAppear {
                 self.fetchData(from: "https://www.apple.com") { result in
                     switch result {
                     case .success(let str):
                         print(str)
                     case .failure(let error):
                         switch error {
                         case .badURL:
                             print("Bad URL")
                         case .requestFailed:
                             print("Bad URL")
                         case .unknown:
                             print("Unknown error")
                         }
                     }
                 }
             }
     }
     
     func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
         guard let url = URL(string: urlString) else {
             completion(.failure(.badURL))
             return
         }

         URLSession.shared.dataTask(with: url) { data, response, error in
             DispatchQueue.main.async {
                 if let data = data {
                     let stringData = String(decoding: data, as: UTF8.self)
                     completion(.success(stringData))
                 } else if error != nil {
                     completion(.failure(.requestFailed))
                 } else {
                     completion(.failure(.unknown))
                 }
             }
         }.resume()
     }
 }
 */

/*
 struct ContentView: View {
     @State private var backgroundColor = Color.red

     var body: some View {
         VStack {
             Text("Hello, World!")
                 .padding()
                 .background(backgroundColor)

             Text("Change Color")
                 .padding()
                 .contextMenu {
                     Button(action: {
                         self.backgroundColor = .red
                     }) {
                         Text("Red")
                     }

                     Button(action: {
                         self.backgroundColor = .green
                     }) {
                         Text("Green")
                     }

                     Button(action: {
                         self.backgroundColor = .blue
                     }) {
                         Text("Blue")
                     }
                 }
         }
     }
 }

 */

/*
 import SwiftUI
 import UserNotifications

 struct ContentView: View {

     
     var body: some View {
         VStack {
             Button("Request Permission") {
                 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .announcement, .badge, .sound]) { success, error in
                     if success {
                         print("Good to go!")
                     } else if let error = error {
                         print(error.localizedDescription)
                     }
                 }
             }
             
             Button("Schedule Notification") {
                 let content = UNMutableNotificationContent()
                 content.title = "Pet Finn"
                 content.subtitle = "Hims needs some lovin"
                 content.sound = UNNotificationSound.default
                 
                 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                 UNUserNotificationCenter.current().add(request)
             }
         }
     }
 }

 */

/*
 import SwiftUI
 import SamplePackage

 struct ContentView: View {
     let possibleNumbers = Array(1...60)
     
     var results: String {
         let selected = possibleNumbers.random(7).sorted()
         return selected.map(String.init).joined(separator: ", ")
     }
     
     var body: some View {
         Text(results)
     }
 }
 */
