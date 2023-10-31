//
//  allStoreyBoards.swift
//  Music App
//
//  Created by Mazhar Hameed on 27/08/2020.
//  Copyright © 2020 Mazhar Hameed. All rights reserved.
//

import Foundation
import UIKit

class allStoryBoards {
    
    static var main: UIStoryboard {
        
        return UIStoryboard(name: "Main", bundle: nil)
    }
    static var LoginVC : LoginVC {
        
        return main.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    }
    
    static var ForgotPasswordVC : ForgotPasswordVC {
        
        return main.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
    }
    static var VerificationCodeVC : VerificationCodeVC {
        return main.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
    }
    static var HomeVC : HomeVC {
        return main.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
    }
    static var MenuVC : MenuVC {
        return main.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
    }
    static var NotificationsVC : NotificationsVC {
        return main.instantiateViewController(withIdentifier: "NotificationsVC") as! NotificationsVC
    }
    static var ProfileVC : ProfileVC {
        return main.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
    }
    static var AboutUsVC : AboutUsVC {
        return main.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
    }
    static var ResetPasswordVC : ResetPasswordVC {
        return main.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
    }
    static var CustomerRequestVC : CustomerRequestVC {
        return main.instantiateViewController(withIdentifier: "CustomerRequestVC") as! CustomerRequestVC
    }
    static var ReportSummaryVC : ReportSummaryVC {
        return main.instantiateViewController(withIdentifier: "ReportSummaryVC") as! ReportSummaryVC
    }
    static var ReportDetailVC : ReportDetailVC {
        return main.instantiateViewController(withIdentifier: "ReportDetailVC") as! ReportDetailVC
    }
    static var ServicesVC : ServicesVC {
        return main.instantiateViewController(withIdentifier: "ServicesVC") as! ServicesVC
    }
    static var ContactUsVC : ContactUsVC {
        return main.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
    }
    static var ReportsVC : ReportsVC {
        return main.instantiateViewController(withIdentifier: "ReportsVC") as! ReportsVC
    }
    static var ReportsHomeVC : ReportsHomeVC {
        return main.instantiateViewController(withIdentifier: "ReportsHomeVC") as! ReportsHomeVC
    }
    //
    static var ViewReportsVC : ViewReportViewController {
        return main.instantiateViewController(withIdentifier: "viewReportsVC") as! ViewReportViewController
    }
    static var PTReuestDetailVC : PTReuestDetailVC {
        return main.instantiateViewController(withIdentifier: "PTReuestDetailVC") as! PTReuestDetailVC
    }
    
}
