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
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 172, blue: 237, alpha: 1)

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
            self.retweetCountLabel.text = String((self.tweet?.retweetCount)! + 1)
            }, failure: { (error) in
                self.createAlert(title: "Oops", message: error.localizedDescription)
        })
    }
    
    @IBAction func onFavoriteClick(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favoriteTweet(id: "\(tweet!.id as! String)", success: {
            self.createAlert(title: "OK", message: "You've favorited this tweet.")
            self.favoritesCountLabel.text = String((self.tweet?.favoritesCount)! + 1)
            }, failure: { (error) in
                self.createAlert(title: "Oops", message: error.localizedDescription)
        })
    }
   
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ReplyTweetSegue") {
            let composeViewController = segue.destination as! ComposeTweetViewController
            composeViewController.handle = "\(handleLabel.text!) "
        }
    }
    
}
