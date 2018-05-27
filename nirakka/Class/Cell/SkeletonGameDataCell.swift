import UIKit
import Material
import Alamofire
import AlamofireImage
import SkeletonView

final class SkeletonGameDataCell: UITableViewCell {

    private var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.4
        return view
    }()

    private var teamLabelView1: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    private var teamLabelView2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    private var vsLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    private var placeLabelView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        contentView.backgroundColor = .white
        backgroundColor = .clear
        self.setupViews()
        showSkeleton()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        contentView.addSubview(bgView)
        bgView.addSubview(teamLabelView1)
        bgView.addSubview(vsLabelView)
        bgView.addSubview(teamLabelView2)
        bgView.addSubview(placeLabelView)

        bgView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        teamLabelView1.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(30)
            $0.right.equalTo(vsLabelView.snp.left).offset(-15)
            $0.height.equalTo(20)
            $0.width.equalTo(80)
        }
        vsLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(10)
            $0.height.equalTo(15)
            $0.width.equalTo(40)
        }
        teamLabelView2.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(30)
            $0.left.equalTo(vsLabelView.snp.right).offset(15)
            $0.height.equalTo(20)
            $0.width.equalTo(80)
        }
        placeLabelView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(5)
            $0.right.equalToSuperview().inset(15)
            $0.height.equalTo(15)
            $0.width.equalTo(80)
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

