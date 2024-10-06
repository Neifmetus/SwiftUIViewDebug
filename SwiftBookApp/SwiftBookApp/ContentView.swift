import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.me)
                .resizable()
                .aspectRatio(16/9, contentMode: .fit)
                .frame(width: 200)
                .fixedSize()
                    .debugSize()
//                    .debugAspectRatio()
            Text("1")
            Text("1")
            Text("1")
        }
        .debugBackground()
        .debugBorder(color: .green, width: 3)
        .padding()
    }
}

#Preview {
    ContentView()
}
