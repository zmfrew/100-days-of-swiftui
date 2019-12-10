import UIKit
import CoreLocation

struct Entry: Identifiable, Codable, Hashable {
    let name: String
    let id: UUID
    let imageData: Data
    let latitude: Double?
    let longitude: Double?
    
    var image: UIImage {
        UIImage(data: imageData) ?? UIImage()
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude ?? 38.624691, longitude: longitude ?? -90.184776)
    }
}
