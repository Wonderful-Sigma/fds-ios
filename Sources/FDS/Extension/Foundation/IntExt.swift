import Foundation

@available(macOS 12, iOS 15, *)
extension Int {
    
    func formatted() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
