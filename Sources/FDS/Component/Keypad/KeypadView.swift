import SwiftUI

@available(macOS 12, iOS 15, *)
public struct KeypadView: View {
    
    @Binding var value: Int
    
    public init(_ value: Binding<Int>) {
        self._value = value
    }
    
    public var body: some View {
        VStack {
            Text("\(value.formatted())")
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 0) {
                ForEach((1...9).map { "\($0)" } + ["00", "0"], id: \.self) { number in
                    Button {
                        value = value * 10 + Int(number)!
                    } label: {
                        Text("\(number)")
                            .font(.system(size: 30, weight: .medium))
                            .padding(.vertical, 17)
                            .frame(maxWidth: .infinity)
                    }
                }
                Button {
                    value = value / 10
                } label: {
                    Image(FlickImage.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 19)
                        .foregroundStyle(Color.lightGray)
                        .frame(maxWidth: .infinity)
                }
            }
            .foregroundStyle(Color.title)
        }
    }
}
