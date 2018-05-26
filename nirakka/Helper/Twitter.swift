import TwitterKit

class TwitterUtils {
    
    let shareURL = "https://spajam.jp/"
    
    func tweet(team: String, yen:Int, completion: @escaping () -> Void) {
        //ユーザー情報があるかどうか調べる
        if let userID = TWTRTwitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            var clientError : NSError?
            let endPoint = "https://api.twitter.com/1.1/statuses/update.json"
            let text = "\n\(team)円を\(yen)に寄付しました. #tipay #\n\(shareURL)"
            let params = ["status" : text]
            
            let request = client.urlRequest(withMethod: "POST", urlString: endPoint, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if (connectionError == nil) {
                    print("sucess");
                    completion()
                }
                else {
                    print(String(describing: connectionError))
                }
            }
        }
    }

}
