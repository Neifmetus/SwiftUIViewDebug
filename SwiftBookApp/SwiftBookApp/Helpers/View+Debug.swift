import SwiftUI

extension View {
    
    func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif
        return self
    }
    
    func debugPrint(_ value: Any) -> Self {
        debugAction {
            print(value)
        }
    }
    
    func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
        #if DEBUG
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func debugBorder(color: Color = .red, width: CGFloat = 1) -> some View {
        debugModifier {
            $0.border(color, width: width)
        }
    }
    
    func debugBackground(color: Color = .red) -> some View {
        debugModifier {
            $0.background(color)
        }
    }
    
    func debugSize(color: Color = .red.opacity(0.7), font: Font = .callout.bold()) -> some View {
        debugModifier {
            $0.overlay(OverlayView(color: color, font: font, style: .size))
        }
    }
    
    func debugAspectRatio(color: Color = .red.opacity(0.7), font: Font = .callout.bold()) -> some View {
        debugModifier {
            $0.overlay(OverlayView(color: color, font: font, style: .aspectRatio))
        }
    }
    
    func debugOverlay(_ text: String, color: Color = .red.opacity(0.7)) -> some View {
        debugModifier {
            $0.overlay(
                Text(text)
                    .font(.callout.bold())
                    .padding(4)
                    .background(color)
            )
        }
    }
}

private struct OverlayView: View {
    
    @State private var size: CGSize = .zero
    let color: Color
    let font: Font
    let style: Style
    enum Style {
        case size
        case aspectRatio
    }
    
    var body: some View {
        Color.clear.readSize(to: $size)
            .overlay(
                Text(style == .size
                     ? String(format: "%.2f", size.width).dropZeros() + "×" + String(format: "%.2f", size.height).dropZeros()
                     : String(format: "%.2f", size.width / size.height).dropZeros()
                    )
                .font(font)
                .padding(4)
                .background(color)
            )
    }
}

private extension String {
    func dropZeros() -> String {
        if hasSuffix(".00") {
            return String(self.dropLast(3))
        } else if hasSuffix(".0") {
            return String(self.dropLast(2))
        } else {
            return self
        }
    }
}

