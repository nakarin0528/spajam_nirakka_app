import UIKit
import Material
import Alamofire
import AlamofireImage
import SkeletonView

final class SkeletonGameDataCell: UICollectionViewCell {

    private var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.4
        return view
    }()

    private var teamLabel1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private var teamLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private var vsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .red
        label.sizeToFit()
        return label
    }()

    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "8月3日 10:00~"
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    private var placeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    private var scoreA: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private var scoreB: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private var scoreBar: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "-"
        label.isHidden = true
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        //        contentView.backgroundColor = .white
        self.setupViews()
        showSkeleton()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        contentView.addSubview(bgView)
        bgView.addSubview(teamLabel1)
        bgView.addSubview(vsLabel)
        bgView.addSubview(teamLabel2)
        bgView.addSubview(timeLabel)
        bgView.addSubview(placeLabel)
        bgView.addSubview(scoreA)
        bgView.addSubview(scoreBar)
        bgView.addSubview(scoreB)

        bgView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        teamLabel1.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(30)
            $0.right.equalTo(vsLabel.snp.left).offset(-10)
        }
        vsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(10)
        }
        teamLabel2.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(30)
            $0.left.equalTo(vsLabel.snp.right).offset(10)
        }
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(placeLabel)
            $0.right.equalTo(placeLabel.snp.left).offset(-15)
        }
        placeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.right.equalToSuperview().inset(15)
        }
        scoreBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(vsLabel.snp.top).offset(-10)
        }
        scoreA.snp.makeConstraints {
            $0.centerY.equalTo(scoreBar)
            $0.right.equalTo(scoreBar.snp.left).offset(-5)
        }
        scoreB.snp.makeConstraints {
            $0.centerY.equalTo(scoreBar)
            $0.left.equalTo(scoreBar.snp.right).offset(5)
        }
    }

    public func showSkeleton() {
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)
        for view in self.bgView.subviews {
            view.isSkeletonable = true
            view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
    }
}

