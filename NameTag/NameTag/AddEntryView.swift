import SwiftUI
import CoreLocation

struct AddEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var inputImage: UIImage?
    @State var name = ""
    @State var showingImagePicker = false
    var model: EntryModel
    var locationFetcher: LocationFetcher
    
    var body: some View {
        NavigationView {
            VStack {
                if inputImage == nil {
                    ZStack {
                        Rectangle()
                            .fill(Color.secondary)
                        
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .onTapGesture {
                        self.showingImagePicker = true
                    }
                } else {
                    Image(uiImage: inputImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 100, alignment: .center)
                }
                
                TextField("Name", text: $name)
                    .padding([.bottom, .top])
                
                Button("Save") {
                    if let data = self.inputImage?.pngData() {
                        self.model.save(Entry(name: self.name,
                                              id: UUID(),
                                              imageData: data,
                                              latitude: self.locationFetcher.lastKnownLocation?.latitude,
                                              longitude: self.locationFetcher.lastKnownLocation?.longitude))
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }.disabled(self.name == "")
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Add a new Name Tag")
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
    }
}
