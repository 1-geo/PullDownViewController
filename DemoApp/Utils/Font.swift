import UIKit

struct Font {
    fileprivate static let montSerratRegularName = "Montserrat Regular"
    fileprivate static let montSerratBoldName = "Montserrat Bold"
    
    static func montSerratRegular(size: CGFloat) -> UIFont?{
        return UIFont(name: montSerratRegularName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func montSerratBold(size: CGFloat) -> UIFont?{
        return UIFont(name: montSerratBoldName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

