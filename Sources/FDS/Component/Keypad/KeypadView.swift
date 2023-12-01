import SwiftUI

@available(macOS 12, iOS 15, *)
public struct TestKeypadView: View {
  
  @Binding var value: Int
  @Binding var myPoint: Int
  
  public init(_ value: Binding<Int>, myPoint: Binding<Int>) {
    self._value = value
    self._myPoint = myPoint
  }
  
  public var body: some View {
    LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 0) {
      ForEach((1...9).map { "\($0)" } + ["00", "0"], id: \.self) { number in
        Button {
          value = value * 10 + Int(number)!
          if number == "00" {
            value *= 10
          }
        } label: {
          Text("\(number)")
            .font(.system(size: 30, weight: .medium))
            .padding(.vertical, 17)
            .frame(maxWidth: .infinity)
        }
        .disabled(value > myPoint)
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
