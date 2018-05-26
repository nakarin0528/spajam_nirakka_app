import UIKit
import SnapKit

final class SearchVC: UIViewController {

    let model = SearchModel()

    private var isFirstFetched = false

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "8月8日"
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 18)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.layer.shadowOffset = CGSize(width: 0, height: 3)
        label.layer.shadowRadius = 3
        label.layer.shadowOpacity = 0.4
        return label
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
            self?.isFirstFetched = false
            self?.tableView.reloadData()
        }
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(dateLabel)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topMargin()).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
        }
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


