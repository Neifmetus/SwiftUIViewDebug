import SwiftUI

extension View {
    
    func measure<Key: PreferenceKey>(
        key: Key.Type,
        value: @escaping (GeometryProxy) -> Key.Value,
        onChange: ((Key.Value) -> Void)? = nil
    ) -> some View where Key.Value: Equatable {
        background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: key,
                    value: value(proxy)
                )
            }
        )
        .onPreferenceChange(key) {
            onChange?($0)
        }
    }
}

protocol HasZero {
    static var zero: Self { get }
}

extension CGSize: HasZero {}

extension EdgeInsets: HasZero {
    static var zero: EdgeInsets { .init() }
}

struct GeneralPreferenceKey<Value: HasZero>: PreferenceKey {
    static var defaultValue: Value { .zero }
    static func reduce(value: inout Value, nextValue: () -> Value) {}
}
