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
        people = []
        load()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func load() {
        let filename = getDocumentsDirectory().appendingPathComponent("People")
        
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print("Error occurred loading data.")
        }
    }
    
    func save() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("People")
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error occurred saving data.")
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
