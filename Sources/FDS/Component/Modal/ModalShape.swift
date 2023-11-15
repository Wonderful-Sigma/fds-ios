import SwiftUI

@available(macOS 12, iOS 15, *)
struct ModalShape: Shape {
  
  let radius: CGFloat = 20
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let w = rect.size.width
    let h = rect.size.height
    let radius = min(min(self.radius, h/2), w/2)
    
    path.move(to: CGPoint(x: w / 2.0, y: 0))
    path.addLine(to: CGPoint(x: w - radius, y: 0))
    path.addArc(center: CGPoint(x: w - radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: -90),
                endAngle: Angle(degrees: 0), clockwise: false)
    
    path.addLine(to: CGPoint(x: w, y: h - 0))
    path.addLine(to: CGPoint(x: 0, y: h))
    
    path.addLine(to: CGPoint(x: 0, y: radius))
    path.addArc(center: CGPoint(x: radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270), clockwise: false)
    
    path.closeSubpath()
    return path
  }
}
