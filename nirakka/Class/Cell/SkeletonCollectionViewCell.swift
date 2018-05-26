//
//  TimeLineModel.swift
//  nirakka
//
//  Created by Iko Nakari on 2018/05/26.
//  Copyright © 2018年 teamNirakka. All rights reserved.
//

import UIKit
import Material
import Alamofire
import AlamofireImage
import SkeletonView

final class SkeletonCollectionViewCell: UICollectionViewCell {

    private var data = GameData()

    /* Views */
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    let photoView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
//    private let iconBackgroundView: UIView = {
//        let view = UIView()
////        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
//        view.layer.cornerRadius = 15
//        view.layer.masksToBounds = true
//        return view
//    }()
//
//    lazy var saveButtonView: UIView  = {
//        let btn = UIView()
//        btn.layer.cornerRadius = 15
//        return btn
//    }()

    /* life cycle */

    override init(frame _: CGRect) {
        super.init(frame: .zero)
//        contentView.backgroundColor = .white
        self.setupViews()
        showSkeleton()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.contentView.addSubview(bgView)
        self.bgView.addSubview(self.photoView)
//        self.bgView.addSubview(self.iconBackgroundView)
//        self.iconBackgroundView.addSubview(self.saveButtonView)

        bgView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }

        self.photoView.snp.makeConstraints {
            $0.center.equalToSuperview()
            // TODO: リファクタリング?
            let screenSize = UIScreen.main.nativeBounds.size
            switch iPhoneSize.type() {
            case .iPhoneX:
                $0.width.equalTo(screenSize.width/6.8)
                $0.height.equalTo(screenSize.height/6.8)
            case .iPhone8Plus:
                $0.width.equalTo(screenSize.width/6.7)
                $0.height.equalTo(screenSize.height/6.7)
            case .iPhoneSE:
                $0.width.equalTo(screenSize.width/4.67)
                $0.height.equalTo(screenSize.height/4.67)
            default:
                $0.width.equalTo(screenSize.width/4.5)
                $0.height.equalTo(screenSize.height/4.5)
            }
        }
//        self.iconBackgroundView.snp.makeConstraints {
//            $0.size.equalTo(30)
//            $0.top.right.equalToSuperview().inset(5)
//        }
//        self.saveButtonView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.size.equalTo(40)
//        }
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

