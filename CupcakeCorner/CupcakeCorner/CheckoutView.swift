import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderContainer: OrderContainer
    @State private var confirmationMessage = ""
    @State private var alertTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)
                    
                    Text("Your total is $\(self.orderContainer.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                .padding()
                }
            }
            .navigationBarTitle("Check out", displayMode: .inline)
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(alertTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(orderContainer.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "error didn't propagate")")
                self.alertTitle = "Oh no!"
                self.confirmationMessage = "We could not place your order. Please try again!"
                self.showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.alertTitle = "Thank you!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderContainer: OrderContainer(order: Order()))
    }
}
