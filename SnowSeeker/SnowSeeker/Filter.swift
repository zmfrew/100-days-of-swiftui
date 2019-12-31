enum SortType: String {
    case none, alphabetical, country
    
    
    init(_ num: Int) {
        switch num {
        case 1:
            self = .alphabetical
        case 2:
            self = .country
        default:
            self = .none
        }
    }
    
    static var allCases = ["none", "alphabetical", "country"]
    var displayName: String { rawValue }
}
