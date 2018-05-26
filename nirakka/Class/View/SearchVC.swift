import UIKit
import SnapKit

final class SearchVC: UIViewController {

    let model = SearchModel()

    private var isFirstFetched = false

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
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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


