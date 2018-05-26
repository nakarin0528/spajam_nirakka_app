//
//  ExUIViewController.swift
//  firstAR
//
//  Created by Iko Nakari on 2018/05/26.
//  Copyright © 2018年 nakarin0528. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {

    func screenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }

    // iOS11以降ならSafeAreaの上限、iOS10以下ならステータスバーの直下
    func topMargin() -> ConstraintItem {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.snp.topMargin
        } else {
            return self.topLayoutGuide.snp.bottom //ステータスバーの下
        }
    }
    // iOS11以降ならSafeAreaの下限、iOS10以下なら下限
    func bottomMargin() -> ConstraintItem {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.snp.bottomMargin
        } else {
            return self.view.snp.bottomMargin
        }
    }
}
