import CoreHaptics
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("hello")
            Spacer().frame(height: 100)
            Text("World")
        }
    .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
