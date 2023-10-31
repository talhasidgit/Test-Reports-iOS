//
//  SplashScreenVC.swift
//  QRI App
//
//  Created by Mazhar on 30/06/2021.
//

import UIKit
import SwiftyGif
class SplashScreenVC: UIViewController {
    
    //MARK: - IBOoulets
    
    @IBOutlet weak var versionLbl: UILabel!
    @IBOutlet weak var myImg: UIImageView!
    // MARK: - Variables
    
    var timer = Timer()
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        do {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            versionLbl.text = "Version \(appVersion ?? DefaultValue.string)"
            let gif = try UIImage(gifName: "QRI_SPLASH_SCREEN_GIF")
            let imageview = UIImageView(gifImage: gif, loopCount: 1) 
            imageview.contentMode = .scaleAspectFill
            imageview.frame = view.bounds
            view.addSubview(imageview)
        } catch {
            print(error)
        }
    }
    @objc func fire() {
        timer.invalidate()
        self.setHomeAsRoot()
    }
    func setHomeAsRoot()  {
        let vc = allStoryBoards.HomeVC
        vc.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
}
