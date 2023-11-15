import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Image {
  
  init(_ flickImage: FlickImage) {
    self.init(flickImage.rawValue, bundle: .module)
  }
}
