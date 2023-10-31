//
//  ServicesVC.swift
//  QRI App
//
//  Created by Mazhar on 23/06/2021.
//

import UIKit
import Spring
import NVActivityIndicatorView
class ServicesVC: UIViewController {
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var txtSummary: UITextView!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var tblService: UITableView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var learnMoreView: DesignableView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    // MARK: - Variables
    var service : ServicesModal!
    var slug = ""
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        getService()
    }
    override func viewDidLayoutSubviews() {
        self.myView.roundCorners(corners: [.topLeft,.topRight], radius: 15.0)
        setUpViews()
    }
    // MARK: - Button Actions
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLearnMorePressed(_ sender: Any) {
        var serviceName = ""
        if slug == "testing-services" {
            serviceName = "ts"
        }
        else if slug == "calibration-services" {
            serviceName = "calibration"
        }
        else if slug == "pt-services" {
            serviceName = "pt"
        }
        else {
            serviceName = "other"
        }
        guard let url = URL(string: "https://qri.com.pk/\(serviceName)") else { return }
        UIApplication.shared.open(url)
    }
    // MARK: - Functions
    func setUpViews() {
        let redColor = UIColor(red: 232/255, green: 169/255, blue: 46/255, alpha: 1.0)
        let yellowColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
        learnMoreView.applyGradient(colours: [redColor,yellowColor])
        learnMoreView.layer.cornerRadius = 25
        learnMoreView.clipsToBounds = true
    }
    func showData() {
        self.tblService.tableHeaderView = self.summaryView
        self.txtSummary.text = self.service.servicesdata?.service?.summary
        self.lblServiceName.text = self.service.servicesdata?.service?.name
        self.summaryView.frame = UIView(frame: CGRect(x: 0, y: 0, width: Commons.SCREEN_SIZE.width, height: txtSummary.contentSize.height + 10)).frame
        self.tblService.reloadData()
    }
    func getService()  {
        loaderView.startAnimating()
        let serviceVM = ServicesViewModal()
        let params = ["service_slug":slug]
        serviceVM.ServicesApi(params: params) { [weak self](resp) in
            self?.loaderView.stopAnimating()
            switch resp {
            case .success(let resp):
                print(resp)
                if resp.status ?? DefaultValue.bool {
                    self?.tblService.delegate = self
                    self?.tblService.dataSource = self
                    self?.service = resp
                    self?.showData()
                }
                else {
                    Commons.showErrorAlert(msg: resp.error ?? "Something went wrong!")
                }
                
            case .failure(let error):
                Commons.showErrorAlert(msg: error.localizedDescription)
            }
        }
    }
}
// MARK: - Tableview delegates methods
extension ServicesVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.servicesdata?.labs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labData = service.servicesdata?.labs?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabTVC", for: indexPath) as! LabTVC
        cell.lblLabTitle.text = labData?.name
        cell.lblLabDes.text = labData?.summary
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
