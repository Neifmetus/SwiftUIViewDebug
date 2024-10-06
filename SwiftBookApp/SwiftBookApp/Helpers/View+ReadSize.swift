import SwiftUI

extension View {
    func readSize<Key: PreferenceKey>(
        key: Key.Type = GeneralPreferenceKey<CGSize>.self,
        onChange: @escaping (CGSize) -> Void
    ) -> some View where Key.Value == CGSize {
        measure(
            key: key,
            value: { $0.size },
            onChange: onChange
        )
    }
    
    func readSize(to value: Binding<CGSize>) -> some View {
        readSize { value.wrappedValue = $0 }
    }
}
