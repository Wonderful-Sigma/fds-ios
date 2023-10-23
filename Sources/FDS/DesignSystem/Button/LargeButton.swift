import SwiftUI

@available(macOS 12, iOS 15, *)
public struct LargeButton: View {
    
    let title: String
    let showChevron: Bool
    let action: () -> Void
    let content: AnyView?
    
    public init(_ title: String,
                showChevron: Bool = true,
                action: @escaping () -> Void) {
        self.title = title
        self.showChevron = showChevron
        self.action = action
        self.content = nil
    }
    
    public init<C: View>(_ title: String,
                         showChevron: Bool = true,
                         action: @escaping () -> Void,
                         @ViewBuilder content: () -> C) {
        self.title = title
        self.showChevron = showChevron
        self.action = action
        self.content = AnyView(content())
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            Button(action: action) {
                HStack {
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color.title)
                    Spacer()
                    if showChevron {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 7, height: 12)
                            .font(.title.weight(.bold))
                            .foregroundStyle(Color.lightgray)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 22)
                .padding(.bottom, content == nil ? 22 : 12)
            }
            if let content {
                content
                    .padding(.horizontal, 25)
                    .padding(.bottom, 22)
            }
        }
        .background(Color.white)
        .cornerRadius(20)
    }
}
