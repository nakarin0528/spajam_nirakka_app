import UIKit

//TODO: リファクタリング、暫定

struct iPhoneSize {
    static func type() -> iPhoneType {
        let nativeWidth = UIScreen.main.nativeBounds.size.width
        
        switch nativeWidth {
        case 640:
            return iPhoneType.iPhoneSE
        case 750:
            return iPhoneType.iPhone8
        case 1080, 1242:
            return iPhoneType.iPhone8Plus
        case 1125:
            return iPhoneType.iPhoneX
        default:
            return iPhoneType.other
        }
    }
}

enum iPhoneType {
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case other
}
