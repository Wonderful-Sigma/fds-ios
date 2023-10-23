import SwiftUI

@available(macOS 12, iOS 15, *)
public extension Color {
    
    static func hexToColor(hex: String) -> UIColor {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        return UIColor(red: CGFloat(int >> 16) / 255,
                       green: CGFloat(int >> 8 & 0xFF) / 255,
                       blue: CGFloat(int & 0xFF) / 255,
                       alpha: 1)
    }
    
    static func dynamicColor(_ light: String, dark: String? = nil) -> Color {
        let lightColor = hexToColor(hex: light)
        if dark == nil {
            return Color(lightColor)
        } else {
            let darkColor = hexToColor(hex: dark!)
            return Color(UIColor { $0.userInterfaceStyle == .dark ? darkColor : lightColor })
        }
    }
    
    static let primary: Color           = dynamicColor("#3250FF")
    static let primaryBackground: Color = dynamicColor("#ECEFFF")
    static let label: Color             = dynamicColor("#353C49")
    static let secondaryLabel: Color    = dynamicColor("#505866")
    static let chevron: Color           = dynamicColor("#B1B8C0")
    static let background: Color        = dynamicColor("#F2F3F4")
    static let foreground: Color        = dynamicColor("#FFFFFF")
}
