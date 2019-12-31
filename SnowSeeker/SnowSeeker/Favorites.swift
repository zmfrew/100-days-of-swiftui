import SwiftUI

final class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.object(forKey: saveKey) as? Data,
            let resorts = try? JSONDecoder().decode(Set<String>.self, from: data) {
            self.resorts = resorts
        } else {
            self.resorts = []
        }
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        let data = try? JSONEncoder().encode(resorts)
        UserDefaults.standard.set(data, forKey: saveKey)
    }
}
