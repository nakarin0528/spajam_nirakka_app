import UIKit
import SnapKit
import Material
import AudioToolbox

final class GameDetailVC: UIViewController {
    let twitterUtils = TwitterUtils()
    let model = TippingModel()
    var tip = Tipping()
    let data: GameData
    var sumA = 0
    var sumB = 0
    
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
    
    private let teamAsum: UILabel = {
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
    
    private let teamBsum: UILabel = {
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
        sumA = data.teamA.sumMoney
        sumB = data.teamB.sumMoney
        teamAsum.text = String(sumA)+"円"
        teamBsum.text = String(sumB)+"円"
        self.data = data
        super.init(nibName: nil, bundle: nil)
        tip.userId = 0
        tip.gameId = data.gameId
        tip.teamAId = data.teamA.id
        tip.teamBId = data.teamB.id
        tip.money = 1000
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "応援しよう！"
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
        view.addSubview(teamAsum)
        view.addSubview(teamB)
        view.addSubview(teamBsum)
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
        teamAsum.snp.makeConstraints {
            $0.centerX.equalTo(backDanboA)
            $0.top.equalTo(backDanboA.snp.bottom).offset(35)
        }
        teamB.snp.makeConstraints {
            $0.centerX.equalTo(backDanboB)
            $0.top.equalTo(backDanboB.snp.bottom).offset(10)
        }
        teamBsum.snp.makeConstraints {
            $0.centerX.equalTo(backDanboB)
            $0.top.equalTo(backDanboA.snp.bottom).offset(35)
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
        Alert.showAction(title: "決定", message: "Do you want to サポペイ？", action: { isSuccess in
            if isSuccess {
                self.animation(btn)
                // 決定した瞬間のバイブ
                if #available(iOS 10.0, *) {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                } else {
                    AudioServicesPlaySystemSound(1003)
                    AudioServicesDisposeSystemSoundID(1003)
                }
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
                self.sumA += 1000
                teamAsum.text = String(self.sumA)+"円"
            }
            self.twitterUtils.tweet(team: data.teamA.name, yen: 1000)
        } else {
            coinImageView.snp.remakeConstraints {
                $0.centerX.equalTo(backDanboB)
                $0.bottom.equalTo(view.snp.top)
                tip.teamId = tip.teamBId
                self.model.fetchDatas(tip:self.tip, completion: { isTrue in
                })
                self.sumB += 1000
                teamBsum.text = String(self.sumB)+"円"
            }
            self.twitterUtils.tweet(team: data.teamB.name, yen: 1000)
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
            if #available(iOS 10.0, *) {
                // コインが入った瞬間のバイブ
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
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
