import UIKit
import SnapKit
import Material

final class SearchVC: UIViewController {

    let model = SearchModel()

    private var isFirstFetched = false

    private var mm = 8
    private var dd = 8

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "試合はありません"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 24)
        label.textColor = .white
        label.isHidden = true
        label.sizeToFit()
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "8月8日"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 18)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = false
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 3
        label.layer.shadowOpacity = 0.4
        return label
    }()

    private lazy var nextBtn: FlatButton = {
        let btn = FlatButton()
        btn.image = R.image.nextIcon()?.tint(.black)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.4
        btn.addTarget(self, action: #selector(nextDidTap), for: .touchUpInside)
        return btn
    }()

    private lazy var backBtn: FlatButton = {
        let btn = FlatButton()
        btn.image = R.image.backIcon()?.tint(.black)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.4
        btn.addTarget(self, action: #selector(backDidTap), for: .touchUpInside)
        return btn
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(GameDataCell.self, forCellReuseIdentifier: "GameDataCell")
        //        table.register(SkeletonCell.self, forCellReuseIdentifier: "SkeletonCell")
        table.estimatedRowHeight = 120
        table.rowHeight = UITableViewAutomaticDimension
        table.tableFooterView = UIView()
        table.backgroundColor = UIColor.app.blue
        table.separatorColor = .clear
        table.keyboardDismissMode = .onDrag
        table.delegate = self
        table.dataSource = self
        table.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        self.refetch(date: "0808")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func refetch(date: String) {
        self.model.searchData.removeAll()
        self.model.fetchDatas(date: date) { [weak self] isSuccess in
            guard let `self` = self else { return }
            self.isFirstFetched = false
            self.tableView.reloadData()
            self.emptyLabel.isHidden = !self.model.searchData.isEmpty
        }
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(dateLabel)
        view.addSubview(backBtn)
        view.addSubview(nextBtn)
        view.addSubview(emptyLabel)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topMargin()).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
        }
        backBtn.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.right.equalTo(dateLabel.snp.left).offset(-15)
            $0.size.equalTo(40)
        }
        nextBtn.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.left.equalTo(dateLabel.snp.right).offset(15)
            $0.size.equalTo(40)
        }
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @objc private func nextDidTap() {
        if mm == 9 && dd == 18 {
            return
        }
        dd += 1
        if mm == 8 && dd > 31 {
            mm += 1
            dd = 1
        }
        if dd < 10 {
            self.refetch(date: "0\(mm)0\(dd)")
        } else {
            self.refetch(date: "0\(mm)\(dd)")
        }
        dateLabel.text = "\(mm)月\(dd)日"
    }

    @objc private func backDidTap() {
        if mm == 8 && dd == 8 {
            return
        }
        dd -= 1
        if dd == 0 {
            mm -= 1
            dd = 31
        }
        if dd < 10 {
            self.refetch(date: "0\(mm)0\(dd)")
        } else {
            self.refetch(date: "0\(mm)\(dd)")
        }
        dateLabel.text = "\(mm)月\(dd)日"
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GameDetailVC(data: self.model.searchData[indexPath.row])
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDataCell") as? GameDataCell ?? GameDataCell()
        cell.configure(self.model.searchData[indexPath.row])

        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        // ローディング用の処理追加する todo

        return self.model.searchData.count
    }
}


