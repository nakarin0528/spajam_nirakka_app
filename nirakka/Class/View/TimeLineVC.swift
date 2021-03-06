import UIKit
import SnapKit

final class TimeLineVC: UIViewController {

    let model = TimeLineModel()

    private var isFirstFetched = true

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(GameDataCell.self, forCellReuseIdentifier: "GameDataCell")
        table.register(SkeletonGameDataCell.self, forCellReuseIdentifier: "SkeletonGameDataCell")
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
        tableView.reloadData()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.refetch()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func refetch(refreshControl: UIRefreshControl? = nil) {
        self.model.timeLineData.removeAll()
        self.model.fetchDatas { [weak self] isSuccess in
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

extension TimeLineVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.model.timeLineData.isEmpty {
            let vc = GameDetailVC(data: self.model.timeLineData[indexPath.row])
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension TimeLineVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.model.timeLineData.count == 0 {
            let skeletonCell = tableView.dequeueReusableCell(withIdentifier: "SkeletonGameDataCell") as! SkeletonGameDataCell
            return skeletonCell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDataCell") as? GameDataCell ?? GameDataCell()
        cell.configure(self.model.timeLineData[indexPath.row])

        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        // ローディング用
        if self.model.timeLineData.count == 0 && self.isFirstFetched {
            return 8
        }

        return self.model.timeLineData.count
    }
}


