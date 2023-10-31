//
//  Extensions.swift
//  ReStreaming
//
//  Created by Mazhar Hameed on 21/12/2020.
//  Copyright © 2020 Mazhar Hameed. All rights reserved.
//

import UIKit
import Foundation
import Toast_Swift
import NVActivityIndicatorView
import BRYXBanner
class Commons: NSObject {
    static let SCREEN_SIZE : CGSize = UIScreen.main.bounds.size
    static let tagGray = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    static var controller : UIViewController!
   // static let win:UIWindow = UIApplication.shared.delegate!.window!!
    
    enum DEVICE_TYPE: String {
        case IPHONE_5
        case IPHONE_6
        case IPHONE_6_PLUS
        case UNKNOWN
    }
    
    static func deviceType() -> DEVICE_TYPE {
        
        if SCREEN_SIZE.width == 320 {
            return .IPHONE_5
        }
        else if SCREEN_SIZE.width == 375 {
            return .IPHONE_6
        }
        else if SCREEN_SIZE.width == 414 {
            return .IPHONE_6_PLUS
        }
        return .UNKNOWN
    }
    // MARK: - Activity indicator
    static func showActivityIndicator(lodingText: String = "Loading") {
        
    }
    
    class func hideActivityIndicator() -> Void {
        
    }
    
    // MARK: - Date Commons
    
    static func formattedCurrentDateTime() -> String {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: String(describing: currentDate))
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        return  dateFormatter.string(from: date!)
    }
    
    static func convertDateFormater(_ date: String) -> String {
        guard !(date.isEmpty) else {return DefaultValue.string}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM d, yyyy"
        return  dateFormatter.string(from: date!)
    }
    static func formatDate(_ date: String) -> String {
        guard !(date.isEmpty) else {return DefaultValue.string}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return  dateFormatter.string(from: date!)
    }
    // MARK: - Redirections
    static func transitionToLoginScreen(){
        let loginVC = allStoryBoards.LoginVC
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
            window.rootViewController?.dismiss(animated: false, completion: nil)
            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        }
    }
    
    
    //MARK: Show Alert
    static   func  showAlert(msg: String)  {
        let alert = UIAlertController(title: "QRI", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))//
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        
    }
    static func showToast(msg: String) {
        var style = ToastStyle()
        style.messageColor = .white
        let color = UIColor(red: 36/255, green: 134/255, blue: 193/255, alpha: 1.0)
        style.backgroundColor = color
        UIApplication.shared.keyWindow?.makeToast(msg, duration: 3.0, position: .bottom, style: style)
    }
    static func showErrorMessage(msg: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.backgroundColor = .black
        UIApplication.shared.keyWindow?.makeToast(msg, duration: 3.0, position: .bottom, style: style)
    }
    static func showErrorAlert(msg:String) {
        let banner = Banner(title: "Error", subtitle: msg, image: UIImage(named: "error"), backgroundColor: .red)
        banner.show(duration: 3.0)
    }
    
    static func updateAppearnce(updatedAppreance: UIUserInterfaceStyle) {
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = updatedAppreance
        } else {
            // Fallback on earlier versions
        }
        var savedAppraence = 0
        if updatedAppreance == .light {
            savedAppraence = 1
        }else if updatedAppreance == .dark {
            savedAppraence = 2
        }
        UserDefaults.standard.set(savedAppraence, forKey: "savedAppreance")
    }
    
    @available(iOS 13.0, *)
    static func getCurrentAppearnce() -> UIUserInterfaceStyle {
        return UIApplication.shared.windows.first?.overrideUserInterfaceStyle ?? UIUserInterfaceStyle.unspecified
    }
}

enum DefaultValue {
    static let string = ""
    static let float: Float = 0.0
    static let double: Double = 0.0
    static let cgfloat: CGFloat = 0.0
    static let bool: Bool = false
    static let int: Int = 0
    static let space = " "
    static let comma = ", "
    static let date : Date = Date()
    static let dateFormat = "MM/dd/yyyy"
    static let timeInterval = TimeInterval(00.00)
    static let notSet = "not set"
}
