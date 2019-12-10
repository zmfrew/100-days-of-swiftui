/*
 struct ContentView: View {
     @State private var blurAmount: CGFloat = 0
     
     var body: some View {
         let blur = Binding<CGFloat>(
             get: {
                 self.blurAmount
         },
             set: {
                 self.blurAmount = $0
                 print("new value is \(self.blurAmount)")
         })
         
         return VStack {
             Text("Hello World")
                 .blur(radius: blurAmount)
             
             Slider(value: blur, in: 0...20)
         }
     }
 }
 */

/*
 struct ContentView: View {
     @State private var showingActionSheet = false
     @State private var backgroundColor = Color.white

     var body: some View {
         Text("Hello, World!")
             .frame(width: 300, height: 300)
             .background(backgroundColor)
             .onTapGesture {
                 self.showingActionSheet = true
             }
         .actionSheet(isPresented: $showingActionSheet) {
             ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                 .default(Text("Red")) { self.backgroundColor = .red },
                 .default(Text("Green")) { self.backgroundColor = .green },
                 .default(Text("Blue")) { self.backgroundColor = .blue },
                 .cancel()
             ])
         }
     }
 }

 */

/*
 import CoreImage
 import CoreImage.CIFilterBuiltins
 import SwiftUI

 struct ContentView: View {
     @State private var image: Image?

     var body: some View {
         VStack {
             image?
                 .resizable()
                 .scaledToFit()
         }
         .onAppear(perform: loadImage)
     }
     
     func loadImage() {
         guard let uiImage = UIImage(named: "field") else { return }
         
         let ciImage = CIImage(image: uiImage)
         let context = CIContext()
         let currentFilter = CIFilter.crystallize() // .sephiaTone()
 //        currentFilter.inputImage = ciImage
         currentFilter.setValue(ciImage, forKey: kCIInputImageKey)
         currentFilter.radius = 15
 //        currentFilter.intensity = 1
         
         guard let outputImage = currentFilter.outputImage,
             let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
         
         let uiImageOutput = UIImage(cgImage: cgImage)
         
         image = Image(uiImage: uiImageOutput)
     }
 }

 */
