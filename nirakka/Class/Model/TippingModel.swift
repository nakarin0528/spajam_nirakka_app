//
//  TippingModel.swift
//  nirakka
//
//  Created by TakutoMori on 2018/05/27.
//  Copyright © 2018年 teamNirakka. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class TippingModel {
    
    var tippingData = [Tipping]()
    var reloadFlg = true
    
    func fetchDatas(tip:Tipping,completion: @escaping (Bool) -> Void) {
        //        guard let accessToken = accessToken else { return }
        //        let headers = [
        //            "Authorization" : "Bearer " + accessToken,
        //            ]
        let url = urlTip
        print(debug: url)
        
        
        let parameters:[String:Any] = [
            "user_id" : tip.userId,
            "team_id" : tip.teamId,
            "game_id" : tip.gameId,
            "money" : tip.money
        ]
        
        
        Alamofire.request(url, method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(debug: json)
                
                let hits = json.array
                hits?.forEach {
                    self.tippingData.append(Tipping($0))
                }
                
                completion(true)
            case let .failure(error):
                print(debug: error)
                // エラー処理を考える
                Alert.show(message: error.localizedDescription)
                completion(false)
                self.reloadFlg = true
            }
        }
        //        var data = GameData()
        //        data.teamA.name = "北海"
        //        data.teamB.name = "滝川西"
        //        data.place = "甲子園球場"
        //        data.startTime = "2018-05-27-10:00"
        //        timeLineData.append(data)
    }
}
