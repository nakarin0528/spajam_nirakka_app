//
//  Tipping.swift
//  nirakka
//
//  Created by TakutoMori on 2018/05/27.
//  Copyright © 2018年 teamNirakka. All rights reserved.
//

import SwiftyJSON

struct Tipping {
    var userId = 0
    var gameId = 0
    var teamAId = 0
    var teamBId = 0
    var teamId = 0
    var money = 0
    var createdAt = ""
    var updatedAt = ""
    
    init() {
    }
    
    init(_ json: JSON) {
        self.userId = json["user_id"].intValue
        self.teamId = json["team_id"].intValue
        self.gameId = json["game_id"].intValue
        self.money = json["money"].intValue
    }
}
