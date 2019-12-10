import SwiftUI

struct ContentView: View {
    @State private var showingDates = true
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.showingDates.toggle()
                }) {
                    Text(self.showingDates ? "Show crew" : "Show dates")
                }
                
                List(missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, allMissions: self.missions)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(self.showingDates ? mission.formattedLaunchDate : mission.crew.map { $0.name }.joined(separator: ", "))
                        }
                    }
                }
                .navigationBarTitle("Moonshot")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 VStack {
     GeometryReader { geo in
         Image("Example")
             .resizable()
             .aspectRatio(contentMode: .fit)
             .frame(width: geo.size.width)
     }
 }
 */

/*
 struct CustomText: View {
     var text: String
     
     var body: some View {
         Text(text)
     }
     
     init(_ text: String) {
         print("Creating a new CustomText")
         self.text = text
     }
 }

 
 ScrollView(.vertical) {
     VStack(spacing: 10) {
         ForEach(0..<100) {
             CustomText("Item \($0)")
                 .font(.title)
         }
     }
     .frame(maxWidth: .infinity)
 }
 */

/*
 NavigationView {
     List(0..<100) { row in
         NavigationLink(destination: Text("Detail \(row)")) {
             Text("Row \(row)")
         }
     }
 }
 .navigationBarTitle("SwiftUI")
 
 */

/*
 struct User: Codable {
     let name: String
     let address: Address
 }

 struct Address: Codable {
     let street: String
     let city: String
 }
 
 Button("Decode JSON") {
     let input = """
     {
         "name": "Taylor Swift",
         "address": {
             "street": "555, Taylor Swift Avenue",
             "city": "Nashville"
         }
     }
     """
     
     let data = Data(input.utf8)
     if let user = try? JSONDecoder().decode(User.self, from: data) {
         print(user.address.street)
     }
 }
 */
