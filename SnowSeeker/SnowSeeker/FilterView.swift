import SwiftUI

struct FilterView: View {
    @Binding var currentFilter: Filter
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            ForEach(0 ..< Filter.allCases.count) { index in
                Button(action: {
                    self.currentFilter = Filter(index)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\(Filter(index).displayName)")
                }
            }
        }
    }
}
