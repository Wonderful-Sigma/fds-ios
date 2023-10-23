import SwiftUI

@available(macOS 12, iOS 15, *)
public struct SmallButton: View {
    
    let title: String
    let highlight: Bool
    let action: () -> Void
    
    public init(_ title: String,
                highlight: Bool = false,
                action: @escaping () -> Void) {
        self.title = title
        self.highlight = highlight
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(highlight
                                 ? Color.blue500
                                 : Color.subtitle)
                .padding(.vertical, 7)
                .padding(.horizontal, title.count > 2 ? 10 : 15)
                .background(highlight
                            ? Color.blue50
                            : Color.container)
                .cornerRadius(7)
        }
    }
}
