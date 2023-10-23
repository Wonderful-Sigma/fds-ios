import SwiftUI
import QRCode

@available(macOS 12, iOS 15, *)
public struct QRCodeView: View {
    
    var document: QRCode.Document {
        let doc = QRCode.Document(utf8String: "Hi there!")
        doc.design.shape.eye = QRCode.EyeShape.Squircle()
        doc.design.shape.pupil = QRCode.PupilShape.Circle()
        doc.design.shape.onPixels = QRCode.PixelShape.RoundedPath()
        doc.design.style.onPixels = QRCode.FillStyle.Solid(Color.subTitle.cgColor!)
        return doc
    }
    
    public var body: some View {
        QRCodeDocumentUIView(document: document)
    }
}

#Preview {
    Preview()
}
