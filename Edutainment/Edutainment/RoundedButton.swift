import SwiftUI

struct RoundedButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 0.5))
            .shadow(color: .black, radius: 1)
    }
}

extension View {
    func roundedButton() -> some View {
        self.modifier(RoundedButton())
    }
}
