import Foundation

struct Activity: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
}
