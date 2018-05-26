import UIKit
import SceneKit
import ARKit

//TODO
fileprivate let duration1: CFTimeInterval = 0.5
fileprivate let duration2: CFTimeInterval = 0.2

class GameDetailVC: UIViewController, ARSCNViewDelegate {

    private lazy var sceneView: ARSCNView = {
        let view = ARSCNView()
        view.delegate = self
        view.showsStatistics = true
        if let scene = SCNScene(named: "art.scnassets/ship.scn") {
            view.scene = scene
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        view.addSubview(sceneView)
        sceneView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate

    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()

     return node
     }
     */

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }

    func testPrint(text: String) -> String {
        //TODO : resetTrachking
        //        return "text test :" + text
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking])
        return "unchi!!!!!!!!!!"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //TODO
        print("touchesBegan")
        // タップ位置のスクリーン座標を取得
        guard let touch = touches.first else {return}
        let pos = touch.location(in: sceneView)

        // 仮想オブジェクトへのヒットテスト
        let isHit = virtualNodeHitTest(pos)

        if !isHit {
            // 検出済み平面へのヒットテスト
            planeHitTest(pos)
        }
    }

    private func virtualNodeHitTest(_ pos: CGPoint) -> Bool {
        //TODO
        print(virtualNodeHitTest)
        // ヒットテストのオプション設定
        let hitTestOptions = [SCNHitTestOption: Any]()

        // ヒットテスト実行
        let results: [SCNHitTestResult] = sceneView.hitTest(pos, options: hitTestOptions)

        // ヒットしたノードに合致する仮想オブジェクトはあるか、再帰的に探す
        for child in sceneView.scene.rootNode.childNodes {
            guard let virtualNode = child as? VirtualObjectNode else {continue}
            for result in results {
                for virtualChild in virtualNode.childNodes {
                    guard virtualChild == result.node else {continue}
                    // 該当するノードにリアクションさせる
                    virtualNode.react()
                    return true
                }
            }
        }
        return false
    }

    private func planeHitTest(_ pos: CGPoint) {
        //TODO
        print("planeHitTest")
        // 平面を対象にヒットテストを実行
        let results = sceneView.hitTest(pos, types: .existingPlaneUsingExtent)

        // ヒット結果のうち、もっともカメラに近いものを取り出す

        if let result = results.first {
            // ヒットした平面のアンカーを取り出す
            guard let anchor = result.anchor else {return}

            // 対応するノードを取得
            guard let node = sceneView.node(for: anchor) else {return}

            // 平面ジオメトリを持つ子ノードを探す
            for child in node.childNodes {
                guard let plane = child.geometry as? SCNPlane else {continue}

                // 半透明にして戻す
                SCNTransaction.begin()
                SCNTransaction.animationDuration = duration1
                SCNTransaction.completionBlock = {
                    SCNTransaction.animationDuration = duration2
                    plane.firstMaterial?.diffuse.contents = UIColor.yellow
                }
                plane.firstMaterial?.diffuse.contents = UIColor.yellow.withAlphaComponent(0.5)
                SCNTransaction.commit()

                break
            }
        }
    }
}

extension SCNNode {
    // TODO
    func react() {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = duration1
        SCNTransaction.completionBlock = {
            SCNTransaction.animationDuration = duration2
            self.opacity = 1.0
        }
        self.opacity = 0.5
        SCNTransaction.commit()
    }
}
