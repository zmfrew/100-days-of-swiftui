import SwiftUI

struct ContentView: View {
    
    @ObservedObject var favorites = Favorites()
    @State private var showingFilterView = false
    @State private var currentSortType: SortType = .none
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var filteredResorts: [Resort] {
        switch currentSortType {
        case .none:
            return resorts
        case .alphabetical:
            return resorts.sorted(by: { $0.name < $1.name })
        case .country:
            return resorts.sorted(by: { $0.country < $1.country })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.showingFilterView = true
                }) {
                    Text("Filter")
                }
                
                List(filteredResorts) { resort in
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                        )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                        )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)
                        
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(Color.red)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingFilterView) {
                SortView(currentSortType: self.$currentSortType)
            }
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
