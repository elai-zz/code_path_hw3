//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Estella Lai on 10/29/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
     @IBOutlet weak var tableView: UITableView!
     var tweets: [Tweet]!
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
          // Do any additional setup after loading the view.
          let twitterClient = TwitterClient.sharedInstance
          twitterClient?.homeTimeline(success: { (tweets) in
               self.tweets = tweets
               self.tableView.reloadData()
               }, failure: { (error) in
                    print(error.localizedDescription)
          })
          
          tableView.delegate = self
          tableView.dataSource = self
          tableView.estimatedRowHeight = 100
          tableView.rowHeight = UITableViewAutomaticDimension
          
          let refreshControl = UIRefreshControl()
          refreshControl.addTarget(self, action: #selector(self.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
          tableView.insertSubview(refreshControl, at: 0)
     }
     
     override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
     }
     
     func refreshControlAction(refreshControl: UIRefreshControl) {
          let twitterClient = TwitterClient.sharedInstance
          twitterClient?.homeTimeline(success: { (tweets) in
               self.tweets = tweets
               self.tableView.reloadData()
               }, failure: { (error) in
                    print(error.localizedDescription)
          })

          // Tell the refreshControl to stop spinning
          refreshControl.endRefreshing()
     }
     
     public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return (tweets != nil) ? tweets.count : 0
     }
     
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "com.TweetCell", for: indexPath) as! TweetCell
          if (tweets) != nil {
               let tweet = self.tweets[indexPath.row]
               cell.tweetLabel.text = tweet.text as String?
               cell.handleLabel.text = "@\(tweet.screenName as! String)"
               cell.profileImageView.setImageWith(tweet.imageURL!)
               cell.timeStampLabel.text = getTimeDifference(createdDate: tweet.timestamp!)
          }
          return cell
     }
     
     func getTimeDifference(createdDate: NSDate) -> String {
          let datetimeNow = NSDate()
          let timeInterval = datetimeNow.timeIntervalSince(createdDate as Date) // in seconds
          if (timeInterval < 60) {
               return "\(Int(ceil(timeInterval)))s"
          } else if (timeInterval < 3600) {
               return "\(Int(ceil(timeInterval/60)))m"
          } else if (timeInterval < 86400) {
               return "\(Int(ceil(timeInterval/3600)))h"
          } else {
               return "\(Int(ceil(timeInterval/86400)))d"
          }
     }
     
     func showTweetDetailViewController(for segue: UIStoryboardSegue, sender: Any?) {
          let cell = sender as! TweetCell
          let indexPath = tableView.indexPath(for: cell)
          let tweet = tweets[(indexPath?.row)!]
          
          let tweetDetailViewController = segue.destination as! TweetDetailViewController
          tweetDetailViewController.tweet = tweet
     }
     
     override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if (segue.identifier == "tweetDetailSegue") {
               showTweetDetailViewController(for: segue, sender: sender)
          }
     }
     
}
