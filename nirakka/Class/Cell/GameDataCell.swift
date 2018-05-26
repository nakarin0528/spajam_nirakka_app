import UIKit
import SnapKit

final class GameDataCell: UITableViewCell {

    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.4
        return view
    }()

    private let teamLabel1: UILabel = {
        let label = UILabel()
        label.text = "広陵"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let teamLabel2: UILabel = {
        let label = UILabel()
        label.text = "花咲徳栄"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let vsLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .red
        label.sizeToFit()
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "8月3日 10:00~"
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // セル選択時のハイライト色を設定
                selectionStyle = .none
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = UIColor.app.warmGray
//        selectedBackgroundView = backgroundView
        backgroundColor = .clear

        setupViews()
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
            $0.bottom.equalToSuperview().inset(10)
            $0.right.equalToSuperview().inset(15)
        }
    }

    func configure(_ data: GameData) {

    }
}
