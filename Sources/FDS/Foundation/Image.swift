import SwiftUI

public enum FlickImage: String {
    
    case logo = "Logo"
}

public extension Image {
    
    init(_ flickImage: FlickImage) {
        self.init(flickImage.rawValue, bundle: .module)
    }
}
