//
//  TeamData.swift
//  nirakka
//
//  Created by TakutoMori on 2018/05/27.
//  Copyright © 2018年 teamNirakka. All rights reserved.
//

import SwiftyJSON

struct TeamData {
    var teamId = 0
    var name = ""
    var prefecture = ""
    var sumMoney = 0
    var createdAt = ""
    var updatedAt = ""
    
    init() {
    }
    
    init(_ json: JSON) {
        self.teamId = json["id"].intValue
        self.name = json["name"].stringValue
        self.prefecture = json["prefecture"].stringValue
        self.sumMoney = json["sum_money"].intValue
    }
}


