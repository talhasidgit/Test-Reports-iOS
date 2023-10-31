//
//  ReportsVC.swift
//  QRI App
//
//  Created by Mazhar on 26/08/2021.
//


import UIKit

class ReportsVC: UIViewController,FileDownloadProtocol {
    // MARK: - IBOutlets
    @IBOutlet weak var tblSummary: UITableView!
    // MARK: - Variables
    var userReports = [File]()
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSummary.delegate = self
        tblSummary.dataSource = self
        
    }
    // MARK: - Button Actions
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Functions
    func downloadFile(index: Int) {
        self.showLoader()
        if let filePath = userReports[index].path {
            guard let url = URL(string: filePath ) else {
                // incorporate error
                return
            }
            FileDownloader.loadFileAsync(url: url) { (path, error,data)  in
                print("PDF File downloaded to : \(path!)")
                DispatchQueue.main.async {
                    self.alert.dismiss(animated: false, completion: nil)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    Commons.showToast(msg: "File downloaded successfully! ")
                    let activityViewController = UIActivityViewController(activityItems: [data!], applicationActivities: nil)
                    self.present(activityViewController, animated: true, completion: nil)
                })
            }
        }
    }
    func showLoader() {
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
}
// MARK: - Tableview delegates
extension ReportsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportSummaryTVC", for: indexPath)
            as! ReportSummaryTVC
        let report = userReports[indexPath.row]
        cell.lblTitle.text = report.file
        cell.btnDownload.tag = indexPath.row
        cell.delegate = self
        cell.btnDownload.setImage(UIImage(named: "donwload_available"), for: .normal)
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.23
        cell.layer.shadowRadius = 4
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

