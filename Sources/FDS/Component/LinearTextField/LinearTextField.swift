import SwiftUI

public struct LinearTextField: View {
  
  @Namespace private var animation
  
  @Binding var text: String
  
  @FocusState private var focus: Bool
  @State private var animatedFocus: Bool = false
  
  let placeholder: String
  let isFirstResponder: Bool
  let isSecured: Bool
  let unit: String?
  let keyboardType: UIKeyboardType
  
  public init(_ placeholder: String,
              text: Binding<String>,
              isFirstResponder: Bool = false,
              isSecured: Bool = false,
              unit: String? = nil,
              keyboardType: UIKeyboardType = .default) {
    self.placeholder = placeholder
    self._text = text
    self.isFirstResponder = isFirstResponder
    self.isSecured = isSecured
    self.unit = unit
    self.keyboardType = keyboardType
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Spacer()
      if animatedFocus {
        Text(placeholder)
          .scaleEffect(0.65, anchor: .leading)
          .foregroundStyle(animatedFocus ? Color.blue500 : .lightGray)
          .matchedGeometryEffect(id: "text", in: animation)
      }
      ZStack(alignment: .leading) {
        if !animatedFocus {
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
        .fill(animatedFocus ? Color.blue500 : .lightGray)
        .frame(height: 1.5)
        .padding(.top, 6)
    }
    .font(.system(size: 20))
    .frame(height: 70)
    .transition(.slide.combined(with: .opacity))
    .onAppear {
      if isFirstResponder {
        focus = true
      }
    }
    .onChange(of: focus) { newValue in
      withAnimation(.easeInOut(duration: 0.2)) {
        animatedFocus = newValue
      }
    }
  }
}

public extension LinearTextField {
  
  @ViewBuilder func makeFirstResponder() -> LinearTextField {
    LinearTextField(self.placeholder,
                    text: self.$text,
                    isFirstResponder: true,
                    isSecured: self.isSecured,
                    unit: self.unit,
                    keyboardType: self.keyboardType)
  }
  
  @ViewBuilder func isSecured(_ condition: Bool) -> LinearTextField {
    LinearTextField(self.placeholder,
                    text: self.$text,
                    isFirstResponder: self.isFirstResponder,
                    isSecured: condition,
                    unit: self.unit,
                    keyboardType: self.keyboardType)
  }
  
  @ViewBuilder func unit(_ string: String) -> LinearTextField {
    LinearTextField(self.placeholder,
                    text: self.$text,
                    isFirstResponder: self.isFirstResponder,
                    isSecured: self.isSecured,
                    unit: string,
                    keyboardType: self.keyboardType)
  }
  
  @ViewBuilder func keyboardType(_ type: UIKeyboardType) -> LinearTextField {
    LinearTextField(self.placeholder,
                    text: self.$text,
                    isFirstResponder: self.isFirstResponder,
                    isSecured: self.isSecured,
                    unit: self.unit,
                    keyboardType: type)
  }
}
