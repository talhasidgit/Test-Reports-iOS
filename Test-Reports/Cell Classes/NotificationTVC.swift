//
//  NotificationTVC.swift
//  QRI App
//
//  Created by Mazhar on 18/06/2021.
//

import UIKit

class NotificationTVC: UITableViewCell {

    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupViews()
    }
    func setupViews() {
        let firstColor = UIColor(red: 114/255, green: 141/255, blue: 177/255, alpha: 1.0)
        let secondColor = UIColor(red: 77/255, green: 112/255, blue: 157/255, alpha: 1.0)
        notificationView.applyGradient(colours: [firstColor,secondColor])
        notificationView.layer.cornerRadius = 20
        notificationView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
