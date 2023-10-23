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
    
    static let lightBlack: Color = dynamicColor("#1A1E27")
    static let title: Color      = dynamicColor("#353C49")
    static let subTitle: Color   = dynamicColor("#505866")
    static let gray: Color       = dynamicColor("#969FA8")
    static let lightGray: Color  = dynamicColor("#B1B8C0")
    static let button: Color     = dynamicColor("#DBDEE2")
    static let container: Color  = dynamicColor("#F2F3F4")
    
    static let blue50: Color  = dynamicColor("#EBEEFF")
    static let blue100: Color = dynamicColor("#BFC9FF")
    static let blue200: Color = dynamicColor("#A1AFFF")
    static let blue300: Color = dynamicColor("#768AFF")
    static let blue400: Color = dynamicColor("#5B73FF")
    static let blue500: Color = dynamicColor("#3250FF")
    static let blue600: Color = dynamicColor("#2E49E8")
    static let blue700: Color = dynamicColor("#2439B5")
    static let blue800: Color = dynamicColor("#1C2C8C")
    static let blue900: Color = dynamicColor("#15226B")
}
