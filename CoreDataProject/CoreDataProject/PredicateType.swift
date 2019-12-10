import Foundation

enum Predicate: String {
    case equals = "=="
    case contains = "IN"
    case beginsWithCaseSensitive = "BEGINSWITH"
    case beginsWithCaseInsensitive = "BEGINSWITH[c]"
    
    var predicateString: String {
        self.rawValue
    }
}
