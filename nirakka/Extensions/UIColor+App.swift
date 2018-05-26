import UIKit

extension UIColor: AppExtensionConvertable {}

extension AppExtension where Base: UIColor {
    static var dustyOrange: UIColor {
        return UIColor(red: 233.0 / 255.0, green: 110.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
    }

    static var orange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 128.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }

    static var whiteOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 185.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    }

    static var untWhiteTwo: UIColor {
        return UIColor(white: 236.0 / 255.0, alpha: 1.0)
    }

    static var warmGray: UIColor {
        return UIColor(red: 0.90, green: 0.90, blue: 0.91, alpha: 1.0)
    }

    static var whiteGray: UIColor {
        return UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
    }

    static var lineGreen: UIColor {
        return UIColor(red: 0.00, green: 0.73, blue: 0.00, alpha: 1.0)
    }

    static var messengerBlue: UIColor {
        return UIColor(red: 0.27, green: 0.54, blue: 1.00, alpha: 1.0)
    }

    static var copypasteGrey: UIColor {
        return UIColor(red: 0.30, green: 0.30, blue: 0.33, alpha: 1.0)
    }

    static var selectedCell: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 242.0 / 255.0, blue: 239 / 255.0, alpha: 1.0)
    }
    
    static var fbColor: UIColor {
        return UIColor(red: 71.0 / 255.0, green: 104.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0)
    }
    
    static var twitterColor: UIColor {
        return UIColor(red: 32.0 / 255.0, green: 163.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    
    static var matBlack: UIColor {
        return UIColor(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)
    }

    static var scrollViewBackgroundColor: UIColor {
        return UIColor(red: 235/255, green: 240/255, blue: 240/255, alpha: 1)
    }

    static var tabBarColor: UIColor {
        return UIColor(red: 210 / 255, green: 210 / 255, blue: 210 / 255, alpha: 1)
    }
    
    static var searchPlaceholderColor: UIColor {
        return UIColor(white: 180.0 / 255.0, alpha: 1.0)
    }
  
    static var borderColor: UIColor {
        return UIColor(red: 227 / 255, green: 227 / 255, blue: 229 / 255, alpha: 1)
    }

    static var heartColor: UIColor {
        return UIColor(red: 255 / 255, green: 90 / 255, blue: 94 / 255, alpha: 1.0)
    }

    static var pink: UIColor {
//        return UIColor(red: 255 / 255, green: 90 / 255, blue: 94 / 255, alpha: 1.0)
        return UIColor(red: 252/255, green: 159/255, blue: 151/255, alpha: 1.0)
    }
}
