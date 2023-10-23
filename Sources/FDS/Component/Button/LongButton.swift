import SwiftUI

public struct LongButton: View {
    
    let title: String
    let type: LongButtonType
    let action: () -> Void
    
    public init(_ title: String,
                type: LongButtonType = .primary,
                action: @escaping () -> Void) {
        self.title = title
        self.type = type
        self.action = action
    }
    
    public var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(type.foregroundColor)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity)
            .background(type.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 17))
    }
    
    public enum LongButtonType {
        
        case primary
        case secondary
        
        var backgroundColor: Color {
            switch self {
            case .primary: return .blue400
            case .secondary: return .blue50
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .primary: return .white
            case .secondary: return .blue400
            }
        }
    }
}
