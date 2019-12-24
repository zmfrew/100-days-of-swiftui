import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                Text("@just_frew_it")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("background")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("ZACHARY FREW")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
            
            VStack {
                Text("Finn")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
            } 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
