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
            let dateLabelStirng = String(describing: tweet.timestamp!)
            let dateLabelArray = dateLabelStirng.components(separatedBy: " ")
            dateLabel.text = "\(dateLabelArray[0]) \(dateLabelArray[1])"
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
            let naviController = segue.destination as! UINavigationController
            let composeViewController = naviController.viewControllers.first as! ComposeTweetViewController
            composeViewController.handle = "\(handleLabel.text!) "
        }
    }
    
}
