//
//  StartVC.swift
//  nirakka
//
//  Created by Iko Nakari on 2018/05/26.
//  Copyright © 2018年 teamNirakka. All rights reserved.
//

import UIKit
import Material
import SnapKit

final class StartVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "タイトル"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()

    private lazy var startBtn: FlatButton = {
        let btn = FlatButton()
        btn.title = "さぁ、はじめよう！"
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.titleColor = .white
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor(red: 255/255, green: 99/255, blue: 71/255, alpha: 1.0)
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.5
        btn.addTarget(self, action: #selector(startDidTap), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 85/255, green: 186/255, blue: 172/255, alpha: 1.0)

        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(screenSize().height/4)
        }

        view.addSubview(startBtn)
        startBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(screenSize().height/4 * 3)
            $0.width.equalTo(170)
            $0.height.equalTo(40)
        }
    }

    @objc private func startDidTap() {
        let tab = TabBarController.shared
        present(tab, animated: true)
    }
}

