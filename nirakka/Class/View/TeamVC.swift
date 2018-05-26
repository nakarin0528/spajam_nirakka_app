import UIKit

final class TeamVC: UIViewController {
    let model = TeamModel()

    private var isFirstFetched = true

    lazy var teamCollectionView: CollectionView = {
        let view = CollectionView(isTL: false)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.app.blue
        self.teamCollectionView.reloadData()
        setupViews()

        self.refetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func refetch() {
                self.model.teamData.removeAll()
                self.model.reloadFlg = true
                self.model.fetchDatas { [weak self] isSuccess in
                    self?.isFirstFetched = false
                    self?.teamCollectionView.reloadData()
                }
    }

    private func setupViews() {
        view.addSubview(teamCollectionView)
        teamCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TeamVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ローディング用
        if self.model.teamData.count == 0 && self.isFirstFetched {
            return 8
        }
        return self.model.teamData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.model.teamData.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkeletonCollectionViewCell", for: indexPath) as! SkeletonCollectionViewCell
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let item = self.model.teamData[indexPath.row]
        cell.configure(data: item)
        return cell
    }
}

extension TeamVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
