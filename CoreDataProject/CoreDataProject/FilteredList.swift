import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, predicate: Predicate, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        let fullPredicate: NSPredicate
        
        switch predicate {
        case .beginsWithCaseInsensitive:
            fullPredicate = NSPredicate(format: "%K \(Predicate.beginsWithCaseInsensitive.predicateString) %@", filterKey, filterValue)
        case .beginsWithCaseSensitive:
            fullPredicate = NSPredicate(format: "%K \(Predicate.beginsWithCaseSensitive.predicateString) %@", filterKey, filterValue)
        case .contains:
            fullPredicate = NSPredicate(format: "%K \(Predicate.contains.predicateString) %@", filterKey, filterValue)
        case .equals:
            fullPredicate = NSPredicate(format: "%K \(Predicate.contains.predicateString) %@", filterKey, filterValue)
        }
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: fullPredicate)
        self.content = content
    }
}
