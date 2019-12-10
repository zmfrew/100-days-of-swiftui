import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    @State private var presentingNoImageError = false
    @State private var currentFilterName = "Sepia Tone"
    let context = CIContext()

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
        })
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)

                Text("Filter: \(self.currentFilterName)")
                
                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.presentingNoImageError = true
                            return
                        }
                        
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success saving image!")
                        }

                        imageSaver.errorHandler = {
                            print("Error occurred saving image: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"), buttons: [
                .default(Text("Crystallize")) {
                    self.setFilter(CIFilter.crystallize())
                    self.currentFilterName = "Crystallize"
                },
                .default(Text("Edges")) { self.setFilter(CIFilter.edges())
                    self.currentFilterName = "Edges"
                },
                .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur())
                    self.currentFilterName = "Gaussian Blur"
                },
                .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate())
                    self.currentFilterName = "Pixellate"
                },
                .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone())
                    self.currentFilterName = "Sepia Tone"
                },
                .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask())
                    self.currentFilterName = "Unsharp Mask"
                },
                .default(Text("Vignette")) { self.setFilter(CIFilter.vignette())
                    self.currentFilterName = "Vignette"
                },
                .cancel()
            ])
        }
        .alert(isPresented: $presentingNoImageError) {
            Alert(title: Text("No image selected."))
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
