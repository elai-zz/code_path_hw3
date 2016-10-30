//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Estella Lai on 10/29/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tweet : Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let tweet = tweet {
            tweetLabel.text = tweet.text as String?
            handleLabel.text = "@\(tweet.screenName as! String)"
            retweetCountLabel.text = String(tweet.retweetCount)
            favoritesCountLabel.text = String(tweet.favoritesCount)
            dateLabel.text = String(describing: tweet.timestamp!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweetClick(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.retweet(id: "\(tweet!.id as! String)", success: {
            self.createAlert(title: "OK", message: "You've retweeted this tweet.")
            self.retweetCountLabel.text = String(tweet?.retweetCount + 1)
            }, failure: { (errorBAD) in
                let error = errorBAD as Error
                self.createAlert(title: "Oops", message: error.localizedDescription)
        })
    }
    
    @IBAction func onFavoriteClick(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favoriteTweet(id: "\(tweet!.id as! String)", success: {
            self.createAlert(title: "OK", message: "You've favorited this tweet.")
            self.favoritesCountLabel.text = String(tweet?.favoritesCount + 1)
            }, failure: { (errorBAD) in
                let error = errorBAD as Error
                self.createAlert(title: "Oops", message: error.localizedDescription)
        })
    }
    
   
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
