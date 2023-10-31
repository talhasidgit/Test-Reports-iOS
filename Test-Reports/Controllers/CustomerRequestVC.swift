//
//  CustomerRequestVC.swift
//  QRI App
//
//  Created by Mazhar on 28/07/2021.
//

import UIKit
import NVActivityIndicatorView
class CustomerRequestVC: UIViewController,FileDownloadProtocol {
    // MARK: - IBOutlets
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var tblRequests: UITableView!
    @IBOutlet weak var myView: UIView!
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    
    // MARK: - Variables
    
    var userRequests : CustomerRequests?
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequests()
        tblRequests.delegate = self
        tblRequests.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        self.setUpViews()
    }
    // MARK: - Button Actions
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    func setUpViews()  {
        self.myView.roundCorners(corners: [.topLeft,.topRight], radius: 15.0)
        
    }
    func getRequests()  {
        loaderView.startAnimating()
        let requestsVM = RequestsViewModal()
        var customerId = 0
        if  let cID = defaults.object(forKey: kCustomerId)  {
            customerId = cID as! Int
        }
        let params = ["customer_id":customerId,"token":defaults.object(forKey: kUserToken) ?? DefaultValue.string]
        requestsVM.RequestsApi(params: params) { [weak self](resp) in
            self?.loaderView.stopAnimating()
            switch resp {
            case .success(let resp):
                print(resp)
                if resp.status ?? DefaultValue.bool {
                    self?.userRequests = resp
                    if let ptReq = self?.userRequests?.requestdata?.ptRequests {
                        for obj in ptReq {
                            self?.userRequests?.requestdata?.testingRequests?.append(obj)
                        }
                       
                    }
                    self?.loaderView.stopAnimating()
                    self?.tblRequests.delegate = self
                    self?.tblRequests.dataSource = self
                    self?.tblRequests.reloadData()
                    
                }
                else {
                    Commons.showErrorAlert(msg: resp.error ?? "Something went wrong!")
                }
                
            case .failure(let error):
                Commons.showErrorAlert(msg: error.localizedDescription)
            }
        }
    }
    func showReport(index:Int) {
        let request = userRequests?.requestdata?.testingRequests?[index]
        loaderView.startAnimating()
    //    ReportsVC
//        //   if userRequests?.requestdata?.testingRequests?[indexPath.row].requestType! == "pt-services" {
//        if request?.status == 3 {
//        cell.myImg.image = UIImage(named: "status_completed")
//        }else{
//            cell.myImg.image = UIImage(named: "status_pending")
//        }
//    }
//   else {
//       if request?.status == 2{
//        cell.myImg.image = UIImage(named: "status_completed")
//
//    }else{
//        cell.myImg.image = UIImage(named: "status_pending")
//
//    }
//   }
        if request?.requestType! == "pt-services" {
        if request?.status == 3 {
        let requestsVM = PTRequestViewModal()
        let params = ["request_id":request?.id ?? "","token":defaults.object(forKey: kUserToken) ?? DefaultValue.string]
        requestsVM.ptRequestApi(params: params) { [weak self](resp) in
            self?.loaderView.stopAnimating()
            switch resp {
            case .success(let resp):
                print(resp)
                if resp.status ?? DefaultValue.bool {
                    FileDownloader.loadFileAsync(url: URL(string:resp.link ?? DefaultValue.string)!) { (path, error,data)  in
                        print("PDF File downloaded to : \(path!)")
                        DispatchQueue.main.async { [self] in
                            self!.alert.dismiss(animated: false, completion: nil)
                            self!.loaderView.stopAnimating()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                            Commons.showToast(msg: "File downloaded successfully! ")
                            let activityViewController = UIActivityViewController(activityItems: [data!], applicationActivities: nil)
                            self!.present(activityViewController, animated: true, completion: nil)
                        })
                    }
                    
                }
                else {
                    self!.loaderView.stopAnimating()
                    Commons.showErrorAlert(msg: resp.error ?? "Something went wrong!")
                }
                
            case .failure(let error):
                self!.loaderView.stopAnimating()
                Commons.showErrorAlert(msg: error.localizedDescription)
            }
         }
     }
     
        }else
            if request?.status == 2 && (request?.files!.count)! > 0{
                self.loaderView.stopAnimating()
                let vc = allStoryBoards.ReportsVC
                vc.modalPresentationStyle = .fullScreen
                vc.userReports = (request?.files)!
                self.present(vc, animated: true, completion: nil)
            }else{
                  self.loaderView.stopAnimating()
                  //Commons.showAlert(msg: "No reports available")
            }
            //{
            
          //  if
//            self.loaderView.stopAnimating()
//            Commons.showAlert(msg: "No reports available")
      //  }
        
        
//        if request?.status != 2 {
//            Commons.showAlert(msg: "No reports available")
//            return
//        }
//        if let files = request?.files {
//            let vc = allStoryBoards.ReportsVC
//            vc.modalPresentationStyle = .fullScreen
//            vc.userReports = files
//            self.present(vc, animated: true, completion: nil)
//        }
//        else {
//            Commons.showAlert(msg: "No reports available")
//        }
        
    }
}
// MARK: - Tableview delegates
extension CustomerRequestVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userRequests?.requestdata?.testingRequests?.count == 0 {
            self.tblRequests.setEmptyMessage("No request found")
        } else {
            self.tblRequests.restore()
        }
        return userRequests?.requestdata?.testingRequests?.count ?? DefaultValue.int
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerRequestTVC", for: indexPath) as! CustomerRequestTVC
        let request = userRequests?.requestdata?.testingRequests?[indexPath.row]
        if let reqNo = request?.requestNumber {
            cell.lblRequestNo.text = "Req#: \(reqNo)"
        }

        if userRequests?.requestdata?.testingRequests?[indexPath.row].requestType! == "testing-services"{
            cell.serviceTypeLbl.text = "Testing Services"
        }else
            if userRequests?.requestdata?.testingRequests?[indexPath.row].requestType! == "calibration-services" {
            cell.serviceTypeLbl.text = "Calibration Services"
        }else
            if userRequests?.requestdata?.testingRequests?[indexPath.row].requestType! == "other-services" {
            cell.serviceTypeLbl.text = "Other Services"
        }else  if userRequests?.requestdata?.testingRequests?[indexPath.row].requestType! == "pt-services" {
            cell.serviceTypeLbl.text = "PT Services"
        }
        
       
        cell.lblDate.text = Commons.formatDate(request?.createdAt ?? "")
        
        if userRequests?.requestdata?.testingRequests?[indexPath.row].requestType! == "pt-services" {
            if request?.status == 3 {
            cell.myImg.image = UIImage(named: "status_completed")
            }else{
                cell.myImg.image = UIImage(named: "status_pending")
                if let image = UIImage(named: "download_unavailable") {
                    cell.btnReport.setImage(image, for: .normal)
                }
            }
        }
       else {
           if request?.status == 2{
            cell.myImg.image = UIImage(named: "status_completed")

        }else{
            cell.myImg.image = UIImage(named: "status_pending")
            if let image = UIImage(named: "download_unavailable") {
                cell.btnReport.setImage(image, for: .normal)
            }
            
        }
       }
            
        
        cell.btnReport.tag = indexPath.row
        cell.delegate = self
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.23
        cell.layer.shadowRadius = 4
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userRequests?.requestdata?.testingRequests?[indexPath.row].requestType == "testing-services" {
            let vc = allStoryBoards.ReportsHomeVC
            vc.modalPresentationStyle = .fullScreen
            vc.requestType = userRequests?.requestdata?.testingRequests?[indexPath.row].requestType ?? DefaultValue.string
            vc.requestId = userRequests?.requestdata?.testingRequests?[indexPath.row].id ?? 0
            self.present(vc, animated: true, completion: nil)
        }
        else {
            let vc = allStoryBoards.PTReuestDetailVC
            vc.modalPresentationStyle = .fullScreen
            vc.requestType = userRequests?.requestdata?.testingRequests?[indexPath.row].requestType ?? DefaultValue.string
            vc.requestId = userRequests?.requestdata?.testingRequests?[indexPath.row].id ?? 0
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}

