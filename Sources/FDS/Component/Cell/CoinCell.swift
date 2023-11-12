import SwiftUI

@available(macOS 12, iOS 15, *)
public struct CoinCell: View {
    
    let title: String
    let value: Int
    let content: AnyView
    
    public init(_ title: String,
                _ value: Int,
                image: URL?) {
        self.title = title
        self.value = value
        self.content = AnyView(
            AsyncImage(url: image) { image in
                image
                    .resizable()
            } placeholder: {
                Image("AccountImage")
            }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        )
    }
    
    public init<C: View>(_ title: String,
                         _ value: Int,
                         @ViewBuilder content: () -> C) {
        self.title = title
        self.value = value
        self.content = AnyView(content())
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            content
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.subTitle)
                Text({ () -> String in
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    let string = numberFormatter.string(from: NSNumber(value: value))
                    return "\(string ?? "0")코인"
                }())
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.title)
            }
        }
    }
}
