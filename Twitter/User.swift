//
//  User.swift responsible for capturing data type on my server
//  Twitter
//
//  Created by Estella Lai on 10/29/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name : NSString?
    var screenName: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    // deserialization code
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String as NSString?
        screenName = dictionary["ame"] as? String as NSString?
        tagline = dictionary["description"] as? String as NSString?
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
    }

}
