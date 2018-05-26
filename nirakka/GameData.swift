import SwiftyJSON

struct GameData {
    var gameId = 0
    var startTime = ""
    var place = ""
    var teamA = Team()
    var teamB = Team()
    var comment = ""
    var imageURL = URL(string: "")
    var isSaved: Bool? = nil
    var listID = 0
    var createdAt = ""
    var updatedAt = ""
    var cacheImage: UIImage? = nil
    var isDone = false
    

    init() {
    }

    init(_ json: JSON) {
        self.gameId = json["id"].intValue
        self.startTime = json["start_time"].stringValue
        self.place = json["place"].stringValue
        self.teamA = Team(json["team_a"])
        self.teamB = Team(json["team_b"])
        self.isDone = json["result"].stringValue != "null"
        if self.isDone {

        }
    }
}

struct Team {
    var name = ""
    var id = 0

    init() {
    }

    init(_ json: JSON) {
        name = json["name"].stringValue
        id = json["id"].intValue
    }
}

struct Result {
    var id = 0
    var gameID = 0
    var scoreA = 0
    var scoreB = 0

    init(_ json: JSON) {

    }
}
