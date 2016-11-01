//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Estella Lai on 10/30/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var tweetTextField: UITextField!
    var handle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.text = handle
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 172, blue: 237, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTweetButton(_ sender: AnyObject) {
        let twitterClient = TwitterClient.sharedInstance
        let rawString = tweetTextField.text
        let formattedString = rawString!.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        twitterClient?.tweet(status: formattedString, success: {
            self.createAlert()
            }, failure: { (error) in
                print("Error : \(error.localizedDescription)")
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        // But I don't know why this works to undo a pushed view
        self.dismiss(animated: true, completion: nil)
    }
    
    func createAlert() {
        let alert = UIAlertController(title: "OK", message: "Your tweet is now live.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
