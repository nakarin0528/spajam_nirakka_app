import UIKit
import SnapKit
import Material

final class GameDetailVC: UIViewController {

    let model = TippingModel()
    var tip = Tipping()
    
    private let backDanboA: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.danbo()?.resize(toWidth: 120)
        return imageView
    }()

    private lazy var frontDanboA: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.danboCover()?.resize(toWidth: 120)
        return imageView
    }()

    private lazy var backDanboB: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.danbo()?.resize(toWidth: 120)
        return imageView
    }()

    private lazy var frontDanboB: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.danboCover()?.resize(toWidth: 120)
        return imageView
    }()

    private let teamA: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 20)
        label.sizeToFit()
        return label
    }()

    private let teamB: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 20)
        label.sizeToFit()
        return label
    }()

    private lazy var btnA: UIButton = {
        let btn = UIButton()
        btn.tag = 0
        btn.addTarget(self, action: #selector(btnDidTap(btn:)), for: .touchUpInside)
        return btn
    }()

    private lazy var btnB: UIButton = {
        let btn = UIButton()
        btn.tag = 1
        btn.addTarget(self, action: #selector(btnDidTap(btn:)), for: .touchUpInside)
        return btn
    }()

    private let coinImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.coin()
        return iv
    }()

    private let coinsA: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.coins()
        iv.isHidden = true
        return iv
    }()

    private let coinsB: UIImageView = {
        let iv = UIImageView()
        iv.image = R.image.coins()
        iv.isHidden = true
        return iv
    }()

    init(data: GameData) {
        teamA.text = data.teamA.name
        teamB.text = data.teamB.name
        super.init(nibName: nil, bundle: nil)
        tip.userId = 0
        tip.gameId = data.gameId
        tip.teamAId = data.teamA.id
        tip.teamBId = data.teamB.id
        tip.money = 100
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ゼニを投げよう！"
        view.backgroundColor = UIColor.app.blue
        navigationController?.navigationBar.isHidden = false

        setupViews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setupViews() {
        view.addSubview(backDanboA)
        view.addSubview(backDanboB)
        view.addSubview(coinImageView)
        view.addSubview(coinsA)
        view.addSubview(coinsB)
        view.addSubview(frontDanboA)
        view.addSubview(frontDanboB)
        view.addSubview(teamA)
        view.addSubview(teamB)
        view.addSubview(btnA)
        view.addSubview(btnB)

        backDanboA.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(30)
        }
        frontDanboA.snp.makeConstraints {
            $0.center.equalTo(backDanboA)
        }
        backDanboB.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(30)
        }
        frontDanboB.snp.makeConstraints {
            $0.center.equalTo(backDanboB)
        }
        teamA.snp.makeConstraints {
            $0.centerX.equalTo(backDanboA)
            $0.top.equalTo(backDanboA.snp.bottom).offset(10)
        }
        teamB.snp.makeConstraints {
            $0.centerX.equalTo(backDanboB)
            $0.top.equalTo(backDanboB.snp.bottom).offset(10)
        }
        btnA.snp.makeConstraints {
            $0.center.size.equalTo(backDanboA)
        }
        btnB.snp.makeConstraints {
            $0.center.size.equalTo(backDanboB)
        }
        coinImageView.snp.makeConstraints {
            $0.centerX.equalTo(backDanboA)
            $0.bottom.equalTo(view.snp.top)
        }
        coinsA.snp.makeConstraints {
            $0.center.equalTo(backDanboA)
        }
        coinsB.snp.makeConstraints {
            $0.center.equalTo(backDanboB)
        }
    }
    
    @objc private func btnDidTap(btn: UIButton) {
        Alert.showAction(title: "決定", message: "Do you want to 投げ銭？", action: { isSuccess in
            if isSuccess {
                self.animation(btn)

            }
        } )
    }

    private func animation(_ btn: UIButton) {
        if btn.tag == 0 {
            coinImageView.snp.remakeConstraints {
                $0.centerX.equalTo(backDanboA)
                $0.bottom.equalTo(view.snp.top)
                tip.teamId = tip.teamAId
                self.model.fetchDatas(tip:self.tip, completion: { isTrue in
                })
            }
        } else {
            coinImageView.snp.remakeConstraints {
                $0.centerX.equalTo(backDanboB)
                $0.bottom.equalTo(view.snp.top)
                tip.teamId = tip.teamBId
                self.model.fetchDatas(tip:self.tip, completion: { isTrue in
                })
            }
        }
        self.view.layoutIfNeeded()
        self.coinImageView.isHidden = false

        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            if btn.tag == 0 {
                self.coinImageView.snp.remakeConstraints {
                    $0.center.equalTo(self.backDanboA)
                }
            } else {
                self.coinImageView.snp.remakeConstraints {
                    $0.center.equalTo(self.backDanboB)
                }
            }
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.coinImageView.isHidden = true
            if btn.tag == 0 {
                self.coinsA.isHidden = false
            }
            if btn.tag == 1 {
                self.coinsB.isHidden = false
            }
        })
    }
}
