//
//  ReportSummaryTVC.swift
//  QRI App
//
//  Created by Mazhar on 21/06/2021.
//
@objc protocol FileDownloadProtocol : class {
    @objc optional func downloadFile(index:Int)
    @objc optional func showReport(index:Int)
}

import UIKit

class ReportSummaryTVC: UITableViewCell {

    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    weak var delegate: FileDownloadProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        delegate.downloadFile!(index: btnDownload.tag)
        
    }
    
}
