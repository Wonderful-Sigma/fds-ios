import SwiftUI

@available(macOS 12, iOS 15, *)
struct QRCodeView: View {
    
    @Binding var data: String?
    
    init(_ data: Binding<String?>) {
        self._data = data
    }
    
    var body: some View {
        VStack {
            if let data {
                QRShape(data)
            } else {
                Text("QR코드를 다시 생성해주세요")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.lightGray)
            }
        }
    }
}

@available(macOS 12, iOS 15, *)
struct QRPreview: View {
    
    @State var data: String?
    
    var body: some View {
         
        QRCodeView($data)
    }
}

#Preview {
    QRPreview()
}
