import UIKit
import Material
import SnapKit
import TwitterKit

final class StartVC: UIViewController {

    private let logoIV: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.logo()?.resize(toHeight: 70)
        return iv
    }()

    private let iconIV: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.neko()
        return iv
    }()

    private lazy var startBtn: FlatButton = {
        let btn = FlatButton()
        btn.title = "さぁ、はじめよう！"
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.titleColor = .white
        btn.layer.cornerRadius = 25
        btn.backgroundColor = UIColor.app.yellow
        btn.pulseColor = .white
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.4
        btn.addTarget(self, action: #selector(startDidTap), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.app.blue
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupViews() {
        view.addSubview(iconIV)
        iconIV.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(335)
            $0.width.equalTo(267)
        }

        view.addSubview(logoIV)
        logoIV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(screenSize().height/4)
        }

        view.addSubview(startBtn)
        startBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(screenSize().height/4 * 3.3)
            $0.width.equalTo(180)
            $0.height.equalTo(50)
        }
    }

    @objc private func startDidTap() {
        let twitterUtils = TwitterUtils()
        twitterUtils.login(on: self){
            
            let tab = TabBarController.shared
            self.present(tab, animated: true)
        }
    }
    
}

extension StartVC: TWTRComposerViewControllerDelegate{
    
}
