import SwiftyJSON

struct GameData {
    var id = 0
    var userID = 0
    var comment = ""
    var imageURL = URL(string: "")
    var isSaved: Bool? = nil
    var listID = 0
    var createdAt = ""
    var updatedAt = ""
    var cacheImage: UIImage? = nil

    init() {
    }

    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.userID = json["user_id"].intValue
        self.comment = json["text"].stringValue
        self.imageURL = URL(string: json["image_url"].stringValue)
        self.createdAt = json["created_at"].stringValue
        self.updatedAt = json["updated_at"].stringValue
    }

    // API完成まで使用
    init(url: URL?, isSaved: Bool? = nil) {
        self.imageURL = url
        self.isSaved = isSaved
    }
    
    // アップロード中に暫定的に表示するためのイニシャライザ
    init(cacheImage:UIImage) {
        self.cacheImage = cacheImage
    }

}
