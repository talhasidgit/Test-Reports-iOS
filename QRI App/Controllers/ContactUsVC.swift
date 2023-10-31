//
//  ContactUsVC.swift
//  QRI App
//
//  Created by Mazhar on 24/06/2021.
//
enum ContactUsOptions : Int {
    case facebook = 0
    case instagram
    case twitter
    case linkedin
}

import UIKit

class ContactUsVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var lblAddress1: UILabel!
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        lblAddress1.isUserInteractionEnabled = true
        lblAddress1.addGestureRecognizer(tap)
        // for address 2
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction2))
        lblAddress2.isUserInteractionEnabled = true
        lblAddress2.addGestureRecognizer(tap2)
    }
    // MARK: - Button Actions
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let myUrl = "comgooglemaps://?saddr=&daddr=31.50805235577207,74.34184665150288"
            if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    }
    @objc func tapFunction2(sender:UITapGestureRecognizer) {
        let myUrl = "comgooglemaps://?saddr=&daddr=33.89691130762862,72.85714077043824"
            if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    }
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnContactUsPressed(_ sender: UIButton) {
        switch sender.tag {
        case ContactUsOptions.facebook.rawValue:
            UIApplication.tryURL(urls: [
                "fb://profile/698947340205382", // App
                "https://www.facebook.com/QRIPakistan/" // Website if app fails
            ])
        case ContactUsOptions.instagram.rawValue:
            UIApplication.tryURL(urls: [
                "instagram://user?username=QRIPakistan", // App
                "https://www.instagram.com/accounts/login/" // Website if app fails
            ])
        case ContactUsOptions.twitter.rawValue:
            UIApplication.tryURL(urls: [
                "twitter://user?screen_name==QRIPakistan", // App
                "https://twitter.com/QRIPakistan/" // Website if app fails
            ])
        case ContactUsOptions.linkedin.rawValue:
            UIApplication.tryURL(urls: [
                "linkedin://profile/qarshi-research-international-trendsetter-of-quality-through-accreditation-3150421a4/", // App
                "https://www.linkedin.com/in/qarshi-research-international-trendsetter-of-quality-through-accreditation-3150421a4/" // Website if app fails
            ])
        default:
            print("Nothing")
        }
    }
    
}
