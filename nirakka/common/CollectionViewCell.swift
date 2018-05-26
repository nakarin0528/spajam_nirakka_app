import UIKit
import Material
import Alamofire
import AlamofireImage

final class CollectionViewCell: UICollectionViewCell {

    private var data = GameData()

    /* Views */

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.sizeToFit()
        label.isHidden = true
        return label
    }()

    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.layer.cornerRadius = 15
        return view
    }()

    lazy var saveButton: FlatButton = {
        let btn = FlatButton()
        btn.layer.cornerRadius = 15
        btn.pulseAnimation = .none
        btn.isExclusiveTouch = true
        btn.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return btn
    }()
    
    // ローディング
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        return indicator
    }()

    /* life cycle */

    override init(frame _: CGRect) {
        super.init(frame: .zero)
//        // 影
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowRadius = 3
//        self.layer.shadowOpacity = 0.5

        self.setupViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(data: GameData, isForFolder:Bool = false) {
        
        self.photoImageView.image = nil
        
        self.data = data
        
        //TODO: AlamofireImageによるキャッシュを実装したので、もしかしたらいらないかも（ないほうがメモリ不足にならないで済むかも）
        if let image = self.data.cacheImage {
            self.photoImageView.image = image
        } else {
            self.activityIndicator.startAnimating()
            if let url = data.imageURL {
                // 非同期でセルがずれたときのため、Alamofireで画像を取得し、判別してからセットする
                Alamofire.request(url).responseImage(completionHandler: { response in
                    if let image = response.result.value {
                        // 万が一セルが別のものに再利用されていた場合は画像を変更しない
                        if self.data.id == data.id {
                            self.photoImageView.image = image
                            self.data.cacheImage = image
                        }
                        
                        // AlamofireImageによるキャッシュ
                        let imageCache = AutoPurgingImageCache()
                        let urlRequest = URLRequest(url: url)
                        imageCache.add(image, for: urlRequest)
                    } else {
                        // 画像取得できなかった時どうしましょ
                        self.photoImageView.image = nil
                    }
                    
                    self.activityIndicator.stopAnimating()
                })
            }
        }

        self.titleLabel.text = data.comment
    }

    @objc private func didTapSaveButton() {
//        Alert.show(message: "開発中です👷‍♂️\n保存できるようにします🙇‍♀️")
    }

    private func setupViews() {
        self.contentView.addSubview(self.photoImageView)
        self.photoImageView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.iconBackgroundView)
        self.iconBackgroundView.addSubview(self.saveButton)
        self.contentView.addSubview(self.activityIndicator)

        self.photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        self.iconBackgroundView.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.right.equalToSuperview().inset(5)
        }
        self.saveButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(40)
        }
        self.activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(60)
        }
    }
}

