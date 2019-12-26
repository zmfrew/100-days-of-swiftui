/*
 struct ContentView: View {
     var body: some View {
         HStack(alignment: .lastTextBaseline) {
             Text("Live")
                 .font(.caption)
             Text("long")
             Text("and")
                 .font(.title)
             Text("prosper")
                 .font(.largeTitle)
         }
     }
 }
 */

/*
 struct ContentView: View {
     var body: some View {
         VStack(alignment: .leading) {
             ForEach(0..<10) { position in
                 Text("Number \(position)")
                     .alignmentGuide(.leading) { _  in CGFloat(position) * -10 }
             }
         }
         .background(Color.red)
         .frame(width: 400, height: 400)
         .background(Color.blue)
     }
 }
 */

/*
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
 */

/*
 struct OuterView: View {
     var body: some View {
         VStack {
             Text("Top")
             InnerView()
                 .background(Color.green)
             Text("Bottom")
         }
     }
 }

 struct InnerView: View {
     var body: some View {
         HStack {
             Text("Left")
             GeometryReader { geo in
                 Text("Center")
                 .background(Color.blue)
                     .onTapGesture {
                         print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                         print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                         print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                     }
             }
             .background(Color.orange)
             Text("Right")
         }
     }
 }

 struct ContentView: View {
     var body: some View {
         OuterView()
             .background(Color.red)
             .coordinateSpace(name: "Custom")
     }
 }

 */
