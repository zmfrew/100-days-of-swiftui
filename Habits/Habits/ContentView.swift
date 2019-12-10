import SwiftUI

struct ContentView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var showingAddHabit = false
    @ObservedObject var activityContainer = ActivityContainer(activities: [])
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.activityContainer.activities) { activity in
                    VStack(alignment: .leading) {
                        Text("\(activity.title)")
                            .font(.headline)
                        Text("\(activity.description)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddHabit) {
               AddView(activityContainer: self.activityContainer)
           }
    }
    
    func removeItems(at offsets: IndexSet) {
        activityContainer.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
