import SwiftUI

final class EntryModel: ObservableObject {
    @Published var entries = [Entry]()
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func load() {
        let filename = getDocumentsDirectory().appendingPathComponent("Entries")

        do {
            let data = try Data(contentsOf: filename)
            entries = try JSONDecoder().decode([Entry].self, from: data).sorted(by: { $0.name < $1.name })
        } catch {
            print("Error occurred loading data.")
        }
    }
    
    func save(_ entry: Entry) {
        entries.append(entry)
        entries.sort(by: { $0.name < $1.name })
        
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("Entries")
            let data = try JSONEncoder().encode(self.entries)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error occurred saving data.")
        }
    }
}
