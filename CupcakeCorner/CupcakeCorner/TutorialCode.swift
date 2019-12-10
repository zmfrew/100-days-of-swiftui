/*
  class User: ObservableObject, Codable {
     @Published var name = "Zach Frew"
     
     enum CodingKeys: CodingKey {
         case name
     }
     
     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         name = try container.decode(String.self, forKey: .name)
     }
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(name, forKey: .name)
     }
 }

 struct Response: Codable {
     var results: [Result]
 }

 struct Result: Codable {
     var trackId: Int
     var trackName: String
     var collectionName: String
 }
 */

/*
 
 struct ContentView: View {
     @State var username = ""
     @State var email = ""
     
     var isFormDisabled: Bool {
         username.count < 5 || email.count < 5
     }
     
     var body: some View {
         Form {
             Section {
                 TextField("Username", text: $username)
                 TextField("Email", text: $email)
             }
             
             Section {
                 Button("Create account") {
                     print("Creating account...")
                 }
             }
             .disabled(isFormDisabled)
         }
     }
 }
 */

/*
@State var results = [Result]()
   
   var body: some View {
       List(results, id: \.trackId) { item in
           VStack(alignment: .leading) {
               Text(item.trackName)
                   .font(.headline)
               Text(item.collectionName)
           }
       }
       .onAppear(perform: loadData)
   }
   
   func loadData() {
       guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else { return }
       
       let request = URLRequest(url: url)
       
       URLSession.shared.dataTask(with: request) { data, _, error in
           if let error = error {
               print("Some bs error happened: \(error)")
           }
           
           guard let data = data,
               let response = try? JSONDecoder().decode(Response.self, from: data) else { return }
           
           DispatchQueue.main.async {
               self.results = response.results
           }
       }.resume()
   }
*/
