import SwiftUI

struct AddressView: View {
    @ObservedObject var orderContainer: OrderContainer
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderContainer.order.name)
                TextField("Street Address", text: $orderContainer.order.streetAddress)
                TextField("City", text: $orderContainer.order.city)
                TextField("Zip", text: $orderContainer.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(orderContainer: orderContainer)) {
                    Text("Check Out")
                }
            }
            .disabled(orderContainer.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderContainer: OrderContainer(order: Order()))
    }
}
