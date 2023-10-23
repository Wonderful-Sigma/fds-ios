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
        
        let rect = CGRect(x: 0.35, y: 0.35, width: 0.3, height: 0.3)
        let path = CGPath(ellipseIn: rect, transform: nil)
        let image = UIImage(named: "QRImage",
                            in: .module,
                            compatibleWith: nil)?.cgImage
        
        doc.logoTemplate = QRCode.LogoTemplate(image: image!, path: path, inset: 3)
        
        return doc
    }
    
    public var body: some View {
        QRCodeDocumentUIView(document: document)
            .frame(width: 50, height: 50)
    }
}

#Preview {
    Preview()
}
