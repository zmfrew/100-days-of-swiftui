import CoreData
import SwiftUI

final class ContentViewModel: ObservableObject {
    let moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func downloadUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { print("Error downloading: \(error!)"); return }
            
            guard let users = try? JSONDecoder().decode([User].self, from: data) else { print("Decoding failed"); return }
            
            self.insert(users)
            
        }.resume()
    }
    
    func insert(_ users: [User]) {
        users.forEach { user in
            let cdUser = CDUser(context: moc)
            cdUser.id = user.id
            cdUser.isActive = user.isActive
            cdUser.name = user.name
            cdUser.age = Int16(user.age)
            cdUser.company = user.company
            cdUser.email = user.email
            cdUser.address = user.address
            cdUser.about = user.about
            cdUser.registered = user.registered
            cdUser.addToFriends(NSSet(array: user.friends.map { friend in
                let cdFriend = CDFriend(context: moc)
                cdFriend.name = friend.name
                cdFriend.id = friend.id
                
                return cdFriend
            }))
            
            try? moc.save()
        }
    }
    
    func loadUsers() {
        
    }
}
