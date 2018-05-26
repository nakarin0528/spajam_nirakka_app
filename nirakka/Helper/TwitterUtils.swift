import TwitterKit

class TwitterUtils
{
    
    func login(on viewController: UIViewController, completion: @escaping () -> Void) {
        let isLoggined = TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()
        print("isLoggined : \(isLoggined)")
        if (isLoggined) {
            completion()
        } else {
            TWTRTwitter.sharedInstance().logIn(with: viewController) { (session, error) in
                if let error = error {
                    completion()
                    return
                }
                if let session = session {
                    completion()
                    return
                }
                completion()
            }
        }   
    }
    
    func tweet(team: String, yen:Int) {
        //ユーザー情報があるかどうか調べる
        if let userID = TWTRTwitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            var clientError : NSError?
            let endPoint = "https://api.twitter.com/1.1/statuses/update.json"
            let text = "\n\(team)に\(yen)円寄付しました. #tipay\n"
            let params = ["status" : text]
            
            let request = client.urlRequest(withMethod: "POST", urlString: endPoint, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if (connectionError == nil) {
                    print("sucess");
                }
                else {
                    print(String(describing: connectionError))
                }
            }
        }
    }

}
