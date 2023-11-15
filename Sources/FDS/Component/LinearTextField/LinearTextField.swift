import SwiftUI

public struct LinearTextField: View {
  
  @Namespace private var animation
  
  @Binding var text: String
  
  @FocusState private var focus: Bool
  
  let placeholder: String
  let isSecured: Bool
  let unit: String?
  
  public init(_ placeholder: String,
              text: Binding<String>,
              isSecured: Bool = false,
              unit: String? = nil) {
    self.placeholder = placeholder
    self._text = text
    self.isSecured = isSecured
    self.unit = unit
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Spacer()
      if focus {
        Text(placeholder)
          .scaleEffect(0.65, anchor: .leading)
          .foregroundStyle(focus ? Color.blue500 : .lightGray)
          .matchedGeometryEffect(id: "text", in: animation)
      }
      ZStack(alignment: .leading) {
        if !focus {
          Text(placeholder)
            .foregroundStyle(Color.lightGray)
            .matchedGeometryEffect(id: "text", in: animation)
        }
        HStack {
          if isSecured {
            SecureField("", text: $text)
              .focused($focus)
          } else {
            TextField("", text: $text)
              .focused($focus)
              .autocapitalization(.none)
          }
          if let unit {
            Text(unit)
          }
        }
      }
      Rectangle()
        .fill(focus ? Color.blue500 : .lightGray)
        .frame(height: 1.5)
        .padding(.top, 6)
    }
    .font(.system(size: 20))
    .frame(height: 70)
    .transition(.slide.combined(with: .opacity))
  }
}

public extension LinearTextField {
  
  @ViewBuilder func isSecured(_ condition: Bool) -> LinearTextField {
    LinearTextField(self.placeholder,
                    text: self.$text,
                    isSecured: condition,
                    unit: self.unit)
  }
  
  @ViewBuilder func unit(_ string: String) -> LinearTextField {
    LinearTextField(self.placeholder,
                    text: self.$text,
                    isSecured: self.isSecured,
                    unit: string)
  }
}
