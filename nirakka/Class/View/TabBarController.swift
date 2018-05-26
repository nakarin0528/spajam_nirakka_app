import UIKit
import Material

final class TabBarController: UITabBarController {

    private static var sharedInstance: TabBarController?

    static var shared: TabBarController = {
        if let sharedInstance = TabBarController.sharedInstance {
            return sharedInstance
        }
        TabBarController.sharedInstance = TabBarController()
        return TabBarController.sharedInstance!
    }()

    static func deleteShared() {
        TabBarController.sharedInstance = nil
    }

    var controllers = [UIViewController]()
    var lastSelectedIndex = 0

    let genreVC = GenreVC()
    let searchVC = SearchVC()
    let myPageVC = MyPageVC()

    private init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.blue
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tab1 = UINavigationController(rootViewController: genreVC)
        let image1 = R.image.home()?.resize(toWidth: 40)
        tab1.tabBarItem = UITabBarItem(title: "", image: image1, tag: 1)

        let tab2 = UINavigationController(rootViewController: searchVC)
        let image2 = R.image.search()?.resize(toWidth: 40)
        tab2.tabBarItem = UITabBarItem(title: "", image: image2, tag: 2)

        let tab3 = UINavigationController(rootViewController: myPageVC)
        let image3 = R.image.profile()?.resize(toWidth: 30)
        tab3.tabBarItem = UITabBarItem(title: "", image: image3, tag: 3)

        self.controllers = [
            tab1,
            tab2,
            tab3,
        ]

        self.setViewControllers(self.controllers, animated: false)

        //tabBarの上枠線を作成
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.lightGray.cgColor
        self.tabBar.layer.addSublayer(topBorder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
