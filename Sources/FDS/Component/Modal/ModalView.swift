import SwiftUI

@available(macOS 12, iOS 15, *)
public struct ModalView<C: View, V: View>: View {
  
  @State var animatedPresentation: Bool
  @State var startOffset: CGFloat?
  @State var dragOffset: CGFloat = 0
  
  @Binding var isPresented: Bool
  let content: () -> C
  let view: () -> V
  
  public init(isPresented: Binding<Bool>,
              @ViewBuilder content: @escaping () -> C,
              @ViewBuilder view: @escaping () -> V) {
    self.animatedPresentation = isPresented.wrappedValue
    self._isPresented = isPresented
    self.content = content
    self.view = view
  }
  
  public var body: some View {
    view()
      .onChange(of: isPresented) { newValue in
        withAnimation(.spring(duration: 0.3)) {
          animatedPresentation = newValue
        }
      }
      .overlay(
        GeometryReader { geometryProxy in
          ZStack(alignment: .bottom) {
            Color.black
              .opacity(animatedPresentation ? 0.5 : 0)
              .ignoresSafeArea()
              .onTapGesture {
                isPresented = false
              }
            if animatedPresentation {
              Color.white
                .frame(height: -min(dragOffset, 0) * 2)
              let bottomSafeArea = geometryProxy.safeAreaInsets.bottom
              VStack(spacing: 0) {
                Capsule()
                  .fill(Color.container)
                  .frame(width: 135, height: 5)
                content()
                  .padding(.vertical, 35)
              }
              .padding(12)
              .padding(.bottom, bottomSafeArea)
              .frame(maxWidth: .infinity)
              .background(Color.white)
              .clipShape(ModalShape())
              .background(ModalShape()
                .stroke(Color.container, lineWidth: 2))
              .offset(y: dragOffset)
              .transition(.move(edge: .bottom))
              .zIndex(1)
              .simultaneousGesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                  .onChanged { newValue in
                    let offset = newValue.location.y
                    if startOffset == nil {
                      startOffset = offset
                    }
                    if let startOffset {
                      let value = -(startOffset - offset)
                      dragOffset = value < 0 ? value / 5 : value
                    }
                  }
                  .onEnded { _ in
                    startOffset = nil
                    if dragOffset > geometryProxy.size.height / 3 {
                      isPresented = false
                    }
                    withAnimation(.spring) {
                      dragOffset = 0
                    }
                  }
              )
            }
          }
          .ignoresSafeArea()
        }
      )
  }
}
