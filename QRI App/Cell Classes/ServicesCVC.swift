//
//  ServicesCVC.swift
//  QRI App
//
//  Created by Mazhar on 02/06/2021.
//

import UIKit

class ServicesCVC: UICollectionViewCell {
    
    @IBOutlet weak var serviceNameLbl: UILabel!
    
    @IBOutlet weak var serviceImg: UIImageView!
    func populateDate(myService:Services) {
        self.serviceNameLbl.text = myService.name
        self.serviceImg.image = UIImage(named: myService.image ?? "")
    }
}
