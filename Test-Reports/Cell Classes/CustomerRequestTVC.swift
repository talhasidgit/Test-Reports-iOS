//
//  CustomerRequestTVC.swift
//  QRI App
//
//  Created by Mazhar on 28/07/2021.
//

import UIKit

class CustomerRequestTVC: UITableViewCell {

    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRequestNo: UILabel!
    @IBOutlet weak var serviceTypeLbl: UILabel!
    weak var delegate : FileDownloadProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func reportBtnPressed(_ sender: Any) {
        delegate?.showReport?(index: btnReport.tag)
    }
    
}
