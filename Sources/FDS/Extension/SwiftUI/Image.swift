import SwiftUI

public enum FlickImage: String {
    
    case logo = "Logo"
    case qrOuterShape = "QROuterShape"
    case reloadIcon = "ReloadIcon"
}

public extension Image {
    
    init(_ flickImage: FlickImage) {
        self.init(flickImage.rawValue, bundle: .module)
    }
}
