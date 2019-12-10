import SwiftUI

final class ActivityContainer: ObservableObject {
    @Published var activities: [Activity] {
        didSet {
            saveData()
        }
    }
    
    init(activities: [Activity]) {
        self.activities = activities
        
        loadData()
    }
    
    private func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("activities.json")
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: fileURL())
            activities = try JSONDecoder().decode([Activity].self, from: data)
        } catch {
            print("Error occurred loading data.")
        }
    }
    
    private func saveData() {
        do {
            let data = try JSONEncoder().encode(activities)
            try data.write(to: fileURL())
        } catch {
            print("Error occurred saving data.")
        }
    }
}
