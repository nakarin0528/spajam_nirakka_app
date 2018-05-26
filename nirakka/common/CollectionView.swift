

import UIKit

final class CollectionView: UICollectionView {

    init(isTL: Bool) {
        super.init(frame: .zero, collectionViewLayout: .init())
        setup()

        register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        register(SkeletonCollectionViewCell.self, forCellWithReuseIdentifier: "SkeletonCollectionViewCell")
        backgroundColor = UIColor.app.scrollViewBackgroundColor
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let layout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.nativeBounds.size
        // TODO: リファクタリング?
        switch iPhoneSize.type() {
        case .iPhoneX:
            layout.itemSize = CGSize(width: screenSize.width/6.8, height: screenSize.height/13.6)
        case .iPhone8Plus:
            layout.itemSize = CGSize(width: screenSize.width/6.7, height: screenSize.height/13.4)
        case .iPhoneSE:
            layout.itemSize = CGSize(width: screenSize.width/4.67, height: screenSize.height/9.34)
        default:
            layout.itemSize = CGSize(width: screenSize.width/4.5, height: screenSize.height/9.0)
        }
        layout.sectionInset = UIEdgeInsetsMake(12, 15, 30, 15) // top left bottom right
        self.collectionViewLayout = layout
    }

}
