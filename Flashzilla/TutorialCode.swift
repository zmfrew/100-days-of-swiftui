/*
 struct ContentView: View {
     @State private var currentAmount: CGFloat = 0
     @State private var finalAmount: CGFloat = 1

     var body: some View {
         Text("Hello, World!")
             .scaleEffect(finalAmount + currentAmount)
             .gesture(
                 MagnificationGesture()
                     .onChanged { amount in
                         self.currentAmount = amount - 1
                     }
                     .onEnded { amount in
                         self.finalAmount += self.currentAmount
                         self.currentAmount = 0
                     }
             )
     }
 }
 */

/*
 struct ContentView: View {
     @State private var currentAmount: Angle = .degrees(0)
     @State private var finalAmount: Angle = .degrees(0)

     var body: some View {
         Text("Hello, World!")
             .rotationEffect(currentAmount + finalAmount)
             .gesture(
                 RotationGesture()
                     .onChanged { angle in
                         self.currentAmount = angle
                     }
                     .onEnded { angle in
                         self.finalAmount += self.currentAmount
                         self.currentAmount = .degrees(0)
                     }
             )
     }
 }
 */

/*
 struct ContentView: View {
     var body: some View {
         VStack {
             Text("Hello, World!")
                 .onTapGesture {
                     print("Text tapped")
                 }
         }
         .highPriorityGesture(
             TapGesture()
                 .onEnded { _ in
                     print("VStack tapped")
                 }
         )
     }
 }
 */

/*
 struct ContentView: View {
     var body: some View {
         VStack {
             Text("Hello, World!")
                 .onTapGesture {
                     print("Text tapped")
                 }
         }
         .simultaneousGesture(
             TapGesture()
                 .onEnded { _ in
                     print("VStack tapped")
                 }
         )
     }
 }
 */

/*
 struct ContentView: View {
     // how far the circle has been dragged
     @State private var offset = CGSize.zero

     // where it is currently being dragged or not
     @State private var isDragging = false

     var body: some View {
         // a drag gesture that updates offset and isDragging as it moves around
         let dragGesture = DragGesture()
             .onChanged { value in self.offset = value.translation }
             .onEnded { _ in
                 withAnimation {
                     self.offset = .zero
                     self.isDragging = false
                 }
             }

         // a long press gesture that enables isDragging
         let tapGesture = LongPressGesture()
             .onEnded { value in
                 withAnimation {
                     self.isDragging = true
                 }
             }

         // a combined gesture that forces the user to long press then drag
         let combined = tapGesture.sequenced(before: dragGesture)

         // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
         return Circle()
             .fill(Color.red)
             .frame(width: 64, height: 64)
             .scaleEffect(isDragging ? 1.5 : 1)
             .offset(offset)
             .gesture(combined)
     }
 }
 */

/*
 struct ContentView: View {
     @State var engine: CHHapticEngine?
     
     var body: some View {
         Text("Hello, World!")
             .onAppear(perform: prepareHaptics)
             .onTapGesture(perform: complexSuccess)
     }
     
     func complexSuccess() {
         // make sure that the device supports haptics
         guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
         var events = [CHHapticEvent]()

         // create one intense, sharp tap
         let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
         let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
         let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
         events.append(event)

         // convert those events into a pattern and play it immediately
         do {
             let pattern = try CHHapticPattern(events: events, parameters: [])
             let player = try engine?.makePlayer(with: pattern)
             try player?.start(atTime: 0)
         } catch {
             print("Failed to play pattern: \(error.localizedDescription).")
         }
     }
     
     func prepareHaptics() {
         guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
         
         do {
             self.engine = try CHHapticEngine()
             try engine?.start()
         } catch {
             print("There was an error creating the engine: \(error.localizedDescription)")
         }
     }
 }
 */

/*
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
 */

/*
 struct ContentView: View {
     let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
     @State private var counter = 0
     
     var body: some View {
         Text("Hello, World!")
             .onReceive(timer) { time in
                 if self.counter == 5 {
                     self.timer.upstream.connect().cancel()
                 } else {
                     print("The time is now \(time)")
                 }
                 
                 self.counter += 1
         }
     }
 }
 */

/*
 struct ContentView: View {
     var body: some View {
         Text("Hello, World!")
             .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                 print("Going to the background")
         }
     }
 }

 */

/*
 struct ContentView: View {
     @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
     
     var body: some View {
         HStack {
             if differentiateWithoutColor {
                 Image(systemName: "checkmark.circle")
             }

             Text("Success")
         }
         .padding()
         .background(differentiateWithoutColor ? Color.black : Color.green)
         .foregroundColor(Color.white)
         .clipShape(Capsule())
     }
 }
 */

/*
 struct ContentView: View {
     @State var scale: CGFloat = 1

     var body: some View {
         Text("Hello, World!")
             .scaleEffect(scale)
             .onTapGesture {
                 withOptionalAnimation {
                     self.scale *= 1.5
                 }
             }
     }
 
     func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
         if UIAccessibility.isReduceMotionEnabled {
             return try body()
         } else {
             return try withAnimation(animation, body)
         }
     }
 }
 */

/*
 struct ContentView: View {
     @Environment(\.accessibilityReduceTransparency) var reduceTransparency
     var body: some View {
         Text("Hello, World!")
             .padding()
             .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
             .foregroundColor(Color.white)
             .clipShape(Capsule())
     }
 }
 */
