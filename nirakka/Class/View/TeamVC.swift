import UIKit

final class TeamVC: UIViewController {
    let model = TimeLineModel()

    private var isFirstFetched = false

    lazy var timeLineView: CollectionView = {
        let view = CollectionView(isTL: false)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        setupViews()

        self.refetch()

        // 引っ張って更新
        let refresh = UIRefreshControl()
        refresh.tintColor = .blue
        if #available(iOS 10.0, *) {
            self.timeLineView.refreshControl = refresh
        } else {
            self.timeLineView.backgroundView = refresh
        }
        refresh.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //テーブルビュー引っ張り時の呼び出しメソッド
    @objc func refreshTable(_ refreshControl: UIRefreshControl){
        //        self.refetch(refreshControl: refreshControl)
    }

    func refetch(refreshControl: UIRefreshControl? = nil) {
        //        self.model.timeLineData.removeAll()
        //        self.model.searchNextPage = 0
        //        self.model.reloadFlg = true
        //        self.model.fetchDatas { [weak self] isSuccess in
        //            self?.isFirstFetched = false
        //            self?.timeLineView.reloadData()
        //            //読込中の表示を消す。
        //            if let refreshControl = refreshControl {
        //                refreshControl.endRefreshing()
        //            }
        //            self?.timeLineView.backgroundColor = UIColor.app.scrollViewBackgroundColor
        //        }
    }

    private func setupViews() {
        view.addSubview(timeLineView)
        timeLineView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TeamVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ローディング用
        if self.model.timeLineData.count == 0 && !self.isFirstFetched {
            self.timeLineView.backgroundColor = .white
            return 8
        }
        return self.model.timeLineData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.model.timeLineData.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkeletonCollectionViewCell", for: indexPath) as! SkeletonCollectionViewCell
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        // TODO:リフレッシュした時にエラーが起きる
        if self.model.timeLineData.count < indexPath.row {
            return cell
        }
        var item = self.model.timeLineData[indexPath.row]
        item.isSaved = false
        cell.configure(data: item)
        return cell
    }
}

extension TeamVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        // 追加読み込み
        //        if self.model.reloadFlg == false { return }
        //        let currentOffsetY = scrollView.contentOffset.y
        //        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        //        let distanceToBottom = maximumOffset - currentOffsetY
        //        if distanceToBottom < 500 {
        //            self.model.fetchDatas { [weak self] _ in
        //                guard let `self` = self else { return }
        //                self.timeLineView.reloadData()
        //            }
        //        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if self.model.timeLineData.count == 0 {
        //            return
        //        }
        //        let detailVC = DetailVC(image: cell.photoImageView.image, screenShotData: self.model.timeLineData[indexPath.row])
        //        detailVC.hidesBottomBarWhenPushed = true
        //        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
