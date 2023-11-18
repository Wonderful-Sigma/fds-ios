import SwiftUI

@available(macOS 12, iOS 15, *)
public struct NavView<C: View>: View {
  
  @Environment(\.dismiss) var dismiss
  @State var shrink: Bool = false
  
  let title: String
  let showsIndicators: Bool
  let backButtonExists: Bool
  let backButtonAction: (() -> Void)?
  let scrollable: Bool
  let trailingView: AnyView?
  let content: () -> C

  public init(_ title: String,
              showsIndicators: Bool = true,
              backButtonExists: Bool = false,
              backButtonAction: (() -> Void)? = nil,
              scrollable: Bool = false,
              trailingView: AnyView? = nil,
              @ViewBuilder content: @escaping () -> C) {
    self.title = title
    self.showsIndicators = showsIndicators
    self.backButtonExists = backButtonExists
    self.backButtonAction = backButtonAction
    self.scrollable = scrollable
    self.trailingView = trailingView
    self.content = content
  }
  
  public var body: some View {
    VStack {
      ZStack {
        Text(title)
          .font(.system(size: 17, weight: .medium))
          .opacity(shrink || !scrollable ? 1 : 0)
          .padding(.vertical, 6)
        HStack(spacing: 26) {
          if backButtonExists {
            Button(action: {
              if let backButtonAction = backButtonAction {
                backButtonAction()
              } else {
                dismiss()
              }
            }) {
              Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10.14, height: 17.77)
                .foregroundStyle(Color(.label))
            }
          }
          Spacer()
          if let trailingView {
            trailingView
          }
        }
        .padding(.horizontal, 18)
      }
      .frame(maxWidth: .infinity)
      if scrollable {
        GeometryReader { outsideProxy in
          ScrollView(showsIndicators: showsIndicators) {
            VStack(spacing: 36) {
              GeometryReader { insideProxy in
                Text(title)
                  .font(.system(size: 26, weight: .bold))
                  .padding(.leading, 24)
                  .onChange(of: insideProxy.frame(in: .global).minY) { newValue in
                    DispatchQueue.main.async {
                      let proxy = outsideProxy.frame(in: .global).minY - newValue
                      withAnimation(.default) {
                        shrink = proxy > 30
                      }
                    }
                  }
              }
              content()
            }
          }
        }
      } else {
        content()
      }
    }
  }
}

public extension NavView {
  
  func backButton(action: (() -> Void)? = nil) -> NavView {
    NavView(self.title,
            showsIndicators: self.showsIndicators,
            backButtonExists: true,
            backButtonAction: action,
            scrollable: self.scrollable,
            trailingView: self.trailingView) {
      self.content()
    }
  }
  
  func trailingView<S: View>(@ViewBuilder content: () -> S) -> NavView {
    NavView(self.title,
            showsIndicators: self.showsIndicators,
            backButtonExists: self.backButtonExists,
            backButtonAction: self.backButtonAction,
            scrollable: self.scrollable,
            trailingView: AnyView(content())) {
      self.content()
    }
  }
}
