import UIKit
import Foundation

struct Helper {
    // 最前面のViewControllerを取得する
    static func frontViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return frontViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return frontViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return frontViewController(controller: presented)
        }
        return controller
    }
    
    // 開けるURLか確認して、開けなければアラートを表示する
    static func check(url: URL, appName: String) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                Alert.show(message: "iOS9以下ではこちらの機能はご利用になれません")
            }
        } else {
            Alert.show(message: "\(appName)を開けませんでした")
            print(debug: "URLが開けませんでした")
        }
    }
}
