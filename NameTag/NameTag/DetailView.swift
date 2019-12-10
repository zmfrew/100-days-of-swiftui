import SwiftUI

struct DetailView: View {
    var entry: Entry
    
    var body: some View {
        VStack(alignment: .center) {
            Text(self.entry.name)
                .font(.title)
            
            Image(uiImage: self.entry.image)
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                
            MapView(centerCoordinate: self.entry.location)
                .frame(width: 400, height: 400)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(entry: Entry(name: "yup", id: UUID(), imageData: Data(), latitude: 0.0, longitude: 0.0))
    }
}
