import UIKit
import SnapKit

final class TimeLineVC: UIViewController {

    let model = TimeLineModel()

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

        self.refetch()

        // 引っ張って更新
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refresh
        } else {
            self.tableView.backgroundView = refresh
        }
        refresh.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //テーブルビュー引っ張り時の呼び出しメソッド
    @objc func refreshTable(_ refreshControl: UIRefreshControl){
        self.refetch(refreshControl: refreshControl)
    }

    func refetch(refreshControl: UIRefreshControl? = nil) {
        self.model.timeLineData.removeAll()
        self.model.fetchDatas { [weak self] isSuccess in
            self?.isFirstFetched = false
            self?.tableView.reloadData()
            //読込中の表示を消す。
            if let refreshControl = refreshControl {
                refreshControl.endRefreshing()
            }
        }
    }

    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TimeLineVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GameDetailVC(data: self.model.timeLineData[indexPath.row])
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension TimeLineVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDataCell") as? GameDataCell ?? GameDataCell()
        cell.configure(self.model.timeLineData[indexPath.row])

        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        // ローディング用の処理追加する todo

        return self.model.timeLineData.count
    }
}


