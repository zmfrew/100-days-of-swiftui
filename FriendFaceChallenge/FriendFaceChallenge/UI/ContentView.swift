import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var model: ContentViewModel
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: []) var users: FetchedResults<CDUser>
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    VStack(alignment: .leading) {
                        Text("\(user.name ?? "no name")")
                            .font(.headline)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        Text("\(user.company ?? "no company")")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        Text("\(user.email ?? "no email")")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onAppear(perform: model.downloadUsers)
        }
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ContentViewModel(moc: NSManagedObjectContext()))
    }
}
*/
