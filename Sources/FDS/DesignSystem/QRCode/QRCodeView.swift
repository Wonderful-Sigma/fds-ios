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
        
        let rect = CGRect(x: 0.35, y: 0.30, width: 0.3, height: 0.3)
        let path = CGPath(ellipseIn: rect, transform: nil)
        
        var image: CGImage {
            let imageView = Image(FlickImage.logo)
                .foregroundStyle(Color.subTitle)
            let controller = UIHostingController(rootView: imageView)

            controller.view.sizeToFit()

            let bounds = controller.view.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
            
            let context = UIGraphicsGetCurrentContext()!
            
            controller.view.layer.render(in: context)
            let cgImage = context.makeImage()
            UIGraphicsEndImageContext()
            return cgImage!
        }
        
        doc.logoTemplate = QRCode.LogoTemplate(image: image, path: path, inset: 8)
        
        return doc
    }
    
    public var body: some View {
        QRCodeDocumentUIView(document: document)
    }
}

#Preview {
    Preview()
}
