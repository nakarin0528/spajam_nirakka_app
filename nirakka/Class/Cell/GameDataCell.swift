import UIKit
import SnapKit

final class GameDataCell: UITableViewCell {
    
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
        label.text = "広陵"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private var teamLabel2: UILabel = {
        let label = UILabel()
        label.text = "花咲徳栄"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private var vsLabel: UILabel = {
        let label = UILabel()
        label.text = "VS"
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
            $0.right.equalTo(placeLabel.snp.left).offset(-35)
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

    func configure(_ data: GameData) {
        teamLabel1.text = data.teamA.name
        teamLabel2.text = data.teamB.name
        var timeL = data.startTime.split(separator: "-")
        var jikan = timeL[2].split(separator: " ")
        var kaishi = jikan[1].split(separator: ":")
        
//        let nen = timeL[0] + "年"
        let getsu = timeL[1] + "月"
        let nichi = jikan[0] + "日"
        let kai = kaishi[0] + "時" + kaishi[1] + "分開始"
        timeLabel.text = String(getsu) + String(nichi) + String(kai)
        placeLabel.text = data.place
        if data.isDone {
            timeLabel.isHidden = true
            scoreA.isHidden = false
            scoreB.isHidden = false
            scoreBar.isHidden = false
            if data.result.scoreA > data.result.scoreB {
                scoreA.textColor = .red
                scoreB.textColor = .black
            } else {
                scoreA.textColor = .black
                scoreB.textColor = .red
            }
            scoreA.text = String(data.result.scoreA)
            scoreB.text = String(data.result.scoreB)
        } else {
            timeLabel.isHidden = false
            scoreA.isHidden = true
            scoreB.isHidden = true
            scoreBar.isHidden = true
        }
    }
}
