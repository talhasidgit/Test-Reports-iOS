//
//  Constants.swift
//  Live-Streaming
//
//  Created by Mazhar Hameed on 12/21/20.
//  Copyright © 2020 Shoaib Ismail. All rights reserved.
//

import Foundation
import UIKit


let kGenericErroMessage = "An Error Occurred Try Again Later"
//UITableViewCell's Identifier


//UIWindow
let currentWindow: UIWindow? = UIApplication.shared.keyWindow
let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
let mainScreenSize = UIScreen.main.bounds.size


//App Colors
let AppYellowColor = UIColor.init(red: 234/255.0, green: 197/255.0, blue: 45/255.0, alpha: 1.0)
let errorBGColor:UIColor = UIColor.init(red: 254.0/255.0, green: 226.0/255.0, blue: 233.0/255.0, alpha: 1.0)
let borderColor:UIColor  = UIColor.init(red: 162.0/255.0, green: 167.0/255.0, blue: 182.0/255.0, alpha: 1.0)
// Defaults
let defaults = UserDefaults.standard


//User

let kUserToken = "access_token"
let kCustomerId = "customerId"
let kUserId = "userId"
let kEmail = "email"
let kUserName = "name"
let kUserProfile = "profile"


func syncronizeDefaults() {
    
    UserDefaults.standard.synchronize()
    
}

var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

