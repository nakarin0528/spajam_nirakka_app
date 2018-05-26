import UIKit
import Material
import Alamofire

final class CollectionViewCell: UICollectionViewCell {

    private var data = TeamData()

    private let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.app.pink
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.4
        return view
    }()

    private let teamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "聖光学院"
        label.textColor = .white
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 20)
        label.sizeToFit()
        return label
    }()

    private let prefectureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "聖光学院"
        label.textColor = .white
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 15)
        label.sizeToFit()
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "金ください！"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 16)
        label.sizeToFit()
        return label
    }()

    /* life cycle */

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        self.setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(data: TeamData, isForFolder:Bool = false) {
        self.data = data
        self.teamLabel.text = data.name
        self.prefectureLabel.text = data.prefecture
        self.commentLabel.text = String(data.sumMoney)+"円"
    }

    @objc private func didTapSaveButton() {
//        Alert.show(message: "開発中です👷‍♂️\n保存できるようにします🙇‍♀️")
    }

    private func setupViews() {
        contentView.addSubview(bgView)
        bgView.addSubview(self.teamLabel)
        bgView.addSubview(self.prefectureLabel)
        bgView.addSubview(self.commentLabel)

        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        teamLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }
        prefectureLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(0)
        }
        commentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

