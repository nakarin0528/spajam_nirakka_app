import ARKit

class VirtualObjectNode: SCNNode {

    init(anchorId: UUID) {
        self.anchorId = anchorId
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let anchorId: UUID
}
