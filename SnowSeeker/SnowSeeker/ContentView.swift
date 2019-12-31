import SwiftUI

enum FilterType: String {
    case country, none, price, size
    
    init(_ num: Int) {
        switch num {
        case 1:
            self = .country
        case 2:
            self = .price
        case 3:
            self = .size
        default:
            self = .none
        }
    }
    
    static var allCases = ["none", "country", "price", "size"]
    var displayName: String { rawValue }
}

struct ContentView: View {
    @State private var currentFilter = ""
    @State private var currentSortType: SortType = .none
    @ObservedObject var favorites = Favorites()
    @State private var showingFilterView = false
    @State private var showingSortView = false
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    var sortedResorts: [Resort] {
        switch currentSortType {
        case .none:
            return resorts
        case .alphabetical:
            return resorts.sorted(by: { $0.name < $1.name })
        case .country:
            return resorts.sorted(by: { $0.country < $1.country })
        }
    }
    
    var filteredResorts: [Resort] {
        guard !currentFilter.isEmpty else { return sortedResorts }
        
        let criteria = currentFilter.lowercased()
        return sortedResorts.filter { $0.country.lowercased().contains(criteria) || $0.size == Int(criteria) || $0.price == Int(criteria) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a country, size of resort, or price", text: $currentFilter)
                
                Button(action: {
                    self.showingSortView = true
                }) {
                    Text("Sort")
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
            .sheet(isPresented: $showingSortView) {
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
