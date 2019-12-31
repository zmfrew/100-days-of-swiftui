import SwiftUI
// TODO: - Use search bar to filter
struct FilterView: View {
    @Binding var currentFilterType: FilterType
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            ForEach(0 ..< FilterType.allCases.count) { index in
                Button(action: {
                    self.currentFilterType = FilterType(index)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\(FilterType(index).displayName)")
                }
            }
        }
    }
}
