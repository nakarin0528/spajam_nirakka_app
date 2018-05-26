import UIKit
import FCAlertView

struct Alert {

    // アラートを表示する
    static func show(title: String = "", message: String) {
        // ダミーのVCを表示する
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        
        let alert = FCAlertView()
        alert.makeAlertTypeCaution()
        alert.doneActionBlock {
            vc.dismiss(animated: true, completion: nil)
        }
        // message内の数字を抽出して条件分岐（API叩いた時のエラー用）
        let splitNumbers =  message.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let number = splitNumbers.joined()
        var finalMessage = ""
        if number == "401" { // トークンが変わってしまっているので再ログインさせる
            finalMessage = "それは不正アクセス"
        } else if number.first == "4" {
            finalMessage = "ご不便をおかけして申し訳ございません。繰り返しても改善されない場合、お手数ですが「マイページ」の「お問い合わせ」よりお問い合わせください。"
        } else if number.first == "5" {
            finalMessage = "ご不便をおかけして申し訳ございません。ただいま復旧作業中ですのでしばらくお待ちください。"
        } else {
            finalMessage = message
        }
        
        Helper.frontViewController()?.present(vc, animated: false, completion: {
            alert.showAlert(inView: vc,
                            withTitle: title,
                            withSubtitle: finalMessage,
                            withCustomImage: nil,
                            withDoneButtonTitle: "閉じる",
                            andButtons: nil
            )
        })
    }
    
    // アラートを表示後、何か処理を行いたいとき
    static func show(title: String = "", message: String, doneAction: @escaping () -> ()) {
        // ダミーのVCを表示する
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        
        let alert = FCAlertView()
        alert.makeAlertTypeCaution()
        alert.doneActionBlock {
            vc.dismiss(animated: true, completion: {
                doneAction()
            })
        }
        
        Helper.frontViewController()?.present(vc, animated: false, completion: {
            alert.showAlert(inView: vc,
                            withTitle: title,
                            withSubtitle: message,
                            withCustomImage: nil,
                            withDoneButtonTitle: "閉じる",
                            andButtons: nil
            )
        })
    }
    
    static func showAction(title: String, message: String, action: @escaping (_ result:Bool) -> ()) {
        // ダミーのVCを表示する
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        
        let alert = FCAlertView()
        
        alert.colorScheme = UIColor.app.pink
        alert.doneActionBlock {
            vc.dismiss(animated: false, completion: nil)
            action(true)
        }
        alert.addButton("キャンセル") {
            vc.dismiss(animated: false, completion: nil)
            action(false)
        }
        
        Helper.frontViewController()?.present(vc, animated: false, completion: {
            alert.showAlert(inView: vc,
                            withTitle: title,
                            withSubtitle: message,
                            withCustomImage: nil,
                            withDoneButtonTitle: "保存",
                            andButtons: nil
            )
        })
    }
    
    // カメラのアクセス許可を促すアラートを表示
    static func showCameraPermission() {
        // ダミーのVCを表示する
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        
        let alert = FCAlertView()
        alert.makeAlertTypeCaution()
        alert.doneActionBlock {
            vc.dismiss(animated: false, completion: nil)
            // 設定画面へ遷移する
            guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
            UIApplication.shared.openURL(url)
        }
        alert.addButton("キャンセル") {
            vc.dismiss(animated: false, completion: nil)
        }
        Helper.frontViewController()?.present(vc, animated: false, completion: {
            alert.showAlert(inView: vc,
                            withTitle: "アクセス許可のお願い",
                            withSubtitle: "設定画面からカメラのアクセスを許可してしてください。お店の写真の追加等に利用します。",
                            withCustomImage: nil,
                            withDoneButtonTitle: "設定画面へ",
                            andButtons: nil
            )
        })
    }

    static func showLoading() {
        // ダミーのVCを表示する
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen

        let alert = FCAlertView()
        alert.makeAlertTypeCaution()
        alert.doneActionBlock {
            vc.dismiss(animated: false, completion: nil)

        }
        Helper.frontViewController()?.present(vc, animated: false, completion: {
            alert.showAlert(inView: vc,
                            withTitle: "更新中です",
                            withSubtitle: "しばらくしてからもう一度お試しください",
                            withCustomImage: nil,
                            withDoneButtonTitle: "OK",
                            andButtons: nil
            )
        })

    }

}
