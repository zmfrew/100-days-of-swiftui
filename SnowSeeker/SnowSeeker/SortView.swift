import SwiftUI

struct SortView: View {
    @Binding var currentSortType: SortType
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            ForEach(0 ..< SortType.allCases.count) { index in
                Button(action: {
                    self.currentSortType = SortType(index)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\(SortType(index).displayName)")
                }
            }
        }
    }
}
