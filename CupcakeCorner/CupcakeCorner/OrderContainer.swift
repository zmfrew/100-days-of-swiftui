import SwiftUI

class OrderContainer: ObservableObject {
    @Published var order: Order
    
    init(order: Order) {
        self.order = order
    }
}
