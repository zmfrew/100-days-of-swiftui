import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RollView()
                .tabItem {
                    Image(systemName: "bolt.circle.fill")
                    Text("Roll")
                }
            
            PreviousRollsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Previous Rolls")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
