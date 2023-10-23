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
        ZStack(alignment: .bottom) {
            view()
                .onChange(of: isPresented) { newValue in
                    withAnimation(.spring) {
                        animatedPresentation = newValue
                    }
                }
            if animatedPresentation {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.spring) {
                            isPresented = false
                        }
                    }
                VStack(spacing: 0) {
                    Capsule()
                        .fill(Color.container)
                        .frame(width: 135, height: 5)
                    content()
                        .padding(.vertical, 35)
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .offset(y: dragOffset)
                .transition(.move(edge: .bottom))
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { newValue in
                            let offset = newValue.location.y
                            if startOffset == nil {
                                startOffset = offset
                            }
                            if let startOffset {
                                dragOffset = -min(startOffset - offset, 0)
                            }
                        }
                        .onEnded { _ in
                            startOffset = nil
                            if dragOffset < 100 {
                                withAnimation(.spring) {
                                    dragOffset = 0
                                }
                            } else {
                                isPresented = false
                            }
                        }
                )
            }
        }
    }
}

struct ModalPreview: View {
    
    @State var isPresented: Bool = true
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
        }
        .modal(isPresented: $isPresented) {
            Text("aa")
        }
    }
}

#Preview {
    ModalPreview()
}
