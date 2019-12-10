import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var model = EntryModel()
    @State var showingAddScreen = false
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            List(model.entries, id: \.self) { entry in
                NavigationLink(destination: DetailView(entry: entry)) {
                    Text(entry.name)
                        .padding(.trailing)
                    
                    HStack {
                        Image(uiImage: entry.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100.0, height: 100.0)
                        
                        MapView(centerCoordinate: entry.location)
                            .frame(width: 100.0, height: 100.0)
                    }                    
                    .onAppear(perform: self.locationFetcher.start)
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
                .navigationBarTitle("NameTag")
                .sheet(isPresented: $showingAddScreen) {
                    AddEntryView(model: self.model, locationFetcher: self.locationFetcher)
            }
            .onAppear(perform: model.load)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
