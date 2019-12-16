import Foundation

final class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anon"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

final class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey),
            let people = try? JSONDecoder().decode([Prospect].self, from: data) {
            self.people = people
            return
        }
        
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
