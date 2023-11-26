import SwiftUI
import QRCode

@available(macOS 12, iOS 15, *)
public struct QRShape: View {
  
  let data: String
  
  public init(_ data: String) {
    self.data = data
  }
  
  var document: QRCode.Document {
    let doc = QRCode.Document(utf8String: data)
    
    doc.design.shape.eye = QRCode.EyeShape.RoundedRect()
    doc.design.shape.pupil = QRCode.PupilShape.Circle()
    doc.design.shape.onPixels = QRCode.PixelShape.RoundedPath()
    doc.design.style.onPixels = QRCode.FillStyle.Solid(Color.subTitle.cgColor!)
    /* 
    /// qr 코드 인식률 감소를 해결하기 위한 주석
    let image = UIImage(named: "QRImage",
                        in: .module,
                        compatibleWith: nil)?.cgImage
    
    doc.logoTemplate = QRCode.LogoTemplate.SquareCenter(image: image!, inset: 0)\
    */
    return doc
  }
  
  public var body: some View {
    QRCodeDocumentUIView(document: document)
  }
}
