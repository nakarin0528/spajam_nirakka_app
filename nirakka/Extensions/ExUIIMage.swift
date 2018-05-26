import Foundation
import UIKit

extension UIImage {
    // 画像の色を変える
    func tint(_ tintColor: UIColor?) -> UIImage {
        guard let tintColor = tintColor else { return self }
        return modifiedImage { context, rect in
            context.setBlendMode(.multiply)
            context.clip(to: rect, mask: self.cgImage!)
            tintColor.setFill()
            context.fill(rect)
        }
    }

    private func modifiedImage( draw: (CGContext, CGRect) -> ()) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        return newImage
    }

    // グラデーションイメージを生成
    class func gradientImage(with size: CGSize, colors: [UIColor], locations: [CGFloat]? = nil, start: CGPoint, end: CGPoint) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map { $0.cgColor } as CFArray, locations: locations) {
            context?.drawLinearGradient(gradient, start: start, end: end, options: CGGradientDrawingOptions())
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
