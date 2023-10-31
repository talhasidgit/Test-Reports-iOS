//
//  ReportSummaryVC.swift
//  QRI App
//
//  Created by Mazhar on 21/06/2021.
//
enum selectedReportChoice : Int {
    case normal_testing = 0
    case calibration
    case proficient_testing
}
struct Summary {
    var title: String!
    var status:String!
    var image :UIImage!
}
import UIKit
import NVActivityIndicatorView
class ReportSummaryVC: UIViewController {
   
    // MARK: - IBOutlets
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var tblSummary: UITableView!
    // MARK: - Variables
    
    var userReports = [TestReport]()
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblSummary.delegate = self
        self.tblSummary.dataSource = self
    }
   
}
// MARK: - Tableview delegates
extension ReportSummaryVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportSummaryTVC", for: indexPath)
            as! ReportSummaryTVC
        let report = userReports[indexPath.row]
        let reportStatus = Int(report.report_status!)
        if reportStatus == 0 {
            cell.statusImageView.isHidden = true
        }else if reportStatus == 1{
            cell.statusImageView.isHidden = false
        }
        cell.lblTitle.text = report.testName
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.23
        cell.layer.shadowRadius = 4
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = allStoryBoards.ReportDetailVC
        let report = userReports[indexPath.row]
        vc.userReport = report
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
}

