//
//  TrackingState+Desription.swift
//  firstAR
//
//  Created by Iko Nakari on 2018/05/26.
//  Copyright © 2018年 nakarin0528. All rights reserved.
//

import ARKit

extension ARCamera.TrackingState {
    public var description: String {
        switch self {
        case .notAvailable:
            return "トラッキングできない！"
        case .normal:
            return "異常なし"
        case .limited(let reason):
            switch reason {
            case .excessiveMotion:
                return "カメラを動かし過ぎです"
            case .insufficientFeatures:
                return "特徴量が足りません"
            case .initializing:
                return "初期化中です"
            case .relocalizing:
                return "再認識中"
            }
        }
    }
}
