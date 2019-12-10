import CoreData
import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    var user: CDUser
    
    var body: some View {
        ScrollView {
            VStack {
                Text(String(self.user.name ?? "no name?"))
                    .font(.title)
                    .padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text("Age: \(self.user.age)")
                    Text("Company: \(self.user.company ?? "no company")")
                    Text("\(self.user.email ?? "no email")")
                }
                .padding(.bottom)
                
                Text("\(self.user.about ?? "no about")")
                    .padding()
                
                Text("\(self.user.address ?? "no address")")
                    .font(.callout)
            }
            .padding()
            
            Text("Friends:")
                .font(.headline)
            
            ForEach(user.friendsArray, id: \.self) { friend in
                NavigationLink(destination: UserDetailView(user: self.cdUser(self.user, friend: friend))) {
                    Text("\(friend.name ?? "no friend name")")
                        .padding()
                }
            }
        }
    }
    
    func cdUser(_ user: CDUser, friend: CDFriend) -> CDUser {
        let cdUser = CDUser(context: self.moc)
        
        cdUser.id =  friend.id
        cdUser.isActive =  false
        cdUser.name = friend.name
        cdUser.age = 0
        cdUser.company =  "N/A"
        cdUser.email = "N/A"
        cdUser.address = "N/A"
        cdUser.about = "This is my about me section. It's supposed to have a bunch of great details on why I'm interesting."
        cdUser.registered = ""
        
        let cdFriend = CDFriend(context: self.moc)
        cdFriend.id = user.id
        cdFriend.name = user.name
        cdUser.friends = NSSet(object: cdFriend)
        
        return cdUser
    }
}
