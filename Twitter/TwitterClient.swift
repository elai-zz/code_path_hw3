//
//  TwitterClient.swift
//  Twitter
//
//  Created by Estella Lai on 10/29/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "G4DqzfqGG2YYquTbDamCGDTeG", consumerSecret: "voiED1iAXdyt8uMAGys8l44dkZgG3esjnmr4nXKwaejDdzOdpL")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (_: URLSessionDataTask, response: Any?) in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            print("name: \(user.name)")
            print("screenname:\(user.screenName)")
            
            }, failure: { (failure: URLSessionDataTask?, error: Error) in
                print("error: \(error.localizedDescription)")})
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            self.loginSuccess?()
            },failure: { (error) in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error as! NSError)
        })
    }
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(
            withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitterdemo://oauth") as URL!, scope: nil,
            success: {(requestToken: BDBOAuth1Credential?) -> Void in
                let token = requestToken?.token
                let string = "https://api.twitter.com/oauth/authorize?oauth_token=\(token!)"
                let url = NSURL(string: string)
                UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
            }, failure: { (error: Error?) -> Void in
                self.loginFailure?(error as! NSError)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: tweetDictionaries)
            success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error as NSError)
        })
    
    }

}