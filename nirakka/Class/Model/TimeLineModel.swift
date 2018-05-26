import Alamofire
import SwiftyJSON

final class TimeLineModel {

    var timeLineData = [GameData]()
    var reloadFlg = true
    var searchNextPage = 0

    func fetchDatas(completion: @escaping (Bool) -> Void) {
//        guard let accessToken = accessToken else { return }
//        let headers = [
//            "Authorization" : "Bearer " + accessToken,
//            ]
//        let url = urlPosts
//        print(debug: url)
//        // 表示するものがない時に、これ以上API叩かないようにするための条件分岐
//        if reloadFlg {
//            reloadFlg = false
//            // API叩く時に、表示したいページ数を添えるための変数
//            guard (searchNextPage+1) >= 1 else { reloadFlg = true; return }
//
//            let params: [String:Int] = [
//                "page": searchNextPage+1,   // はじめのページ数は1
//            ]
//
//            Alamofire.request(url, method: .get, parameters: params, headers: headers).validate().responseJSON { response in
//                switch response.result {
//                case let .success(value):
//                    let json = JSON(value)
//                    print(debug: json)
//
//                    let hits = json["posts"].arrayValue
//
//                    if self.searchNextPage == 0 {
//                        self.timeLineData.removeAll()
//                    }
//
//                    hits.forEach {
//                        self.timeLineData.append(ScreenShotData($0))
//                    }
//
//                    self.searchNextPage += 1
//
//                    if hits.count < 30 {
//                        self.reloadFlg = false
//                    } else {
//                        self.reloadFlg = true
//                    }
//
//                    completion(true)
//                case let .failure(error):
//                    print(debug: error)
//                    // エラー処理を考える
//                    Alert.show(message: error.localizedDescription)
//                    completion(false)
//                    self.reloadFlg = true
//                }
//            }
//        }
    }
}
