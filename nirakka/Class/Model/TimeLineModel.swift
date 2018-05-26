import Alamofire
import SwiftyJSON

final class TimeLineModel {

    var timeLineData = [GameData]()
    var reloadFlg = true

    func fetchDatas(completion: @escaping (Bool) -> Void) {
//        guard let accessToken = accessToken else { return }
//        let headers = [
//            "Authorization" : "Bearer " + accessToken,
//            ]
        let url = urlGames
        print(debug: url)

        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(debug: json)

                let hits = json.array
                hits?.forEach {
                    self.timeLineData.append(GameData($0))
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
