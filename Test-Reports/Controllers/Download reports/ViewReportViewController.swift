//
//  ViewReportViewController.swift
//  QRI App
//
//  Created by Ahmed on 24/11/2021.
//

import UIKit
import PDFKit
import Spring
import TransitionButton

class ViewReportViewController: UIViewController,FileDownloadProtocol {

    @IBOutlet weak var pdfUIView: UIView!
    @IBOutlet weak var jobIdTextField: UITextField!
    @IBOutlet weak var sampleIDTextField: UITextField!
    @IBOutlet weak var getReportButton: TransitionButton!
    @IBOutlet weak var getReportView: DesignableView!
    
    @IBOutlet weak var sampleIDView: DesignableView!
    @IBOutlet weak var jobIDView: DesignableView!
    weak var delegate : FileDownloadProtocol?
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()

        jobIdTextField.attributedPlaceholder = NSAttributedString(string: "Job ID",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        sampleIDTextField.attributedPlaceholder = NSAttributedString(string: "Sample ID",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let redColor = UIColor(red: 232/255, green: 169/255, blue: 46/255, alpha: 1.0)
        let yellowColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
        getReportView.applyGradient(colours: [redColor,yellowColor])
        getReportView.layer.cornerRadius = 25
        getReportView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - GET REPORT
    
    @IBAction func viewReportBtn(_ sender: Any) {
        self.checkValidations()
        
    }
    
    
    // MARK: - Button Actions
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func checkValidations()  {
//        if jobIdTextField.text == "" {
//            Commons.showAlert(msg: "Email is required")
//            return
//        }
//        if !sampleIDTextField.text!.isValidEmail() {
//            Commons.showAlert(msg: "Invalid emil")
//            return
//        }
        self.getReport()
    }
    func getReport()  {
        getReportButton.startAnimation()
        let downloadReport = DownloadReportVCModel()
        let params = ["job_id":jobIdTextField.text!,"sample_id":sampleIDTextField.text!]
        downloadReport.downloadReportApi(params: params) {[weak self] (resp) in
            self?.getReportButton.stopAnimation()
            switch resp {
            case .success(let resp):
                print(resp)
                self?.jobIdTextField.text = ""
                self?.sampleIDTextField.text = ""
                self!.downloadFile(fileUrl: resp.link!)
          
            case .failure(let error):
                Commons.showErrorAlert(msg: error.localizedDescription)
            }
        }
        
    }
    
    //MARK: - Functions
    func downloadFile(fileUrl:String?) {
        self.showLoader()
      //  if let filePath = fileUrl! {
        let url = URL(string: fileUrl!) //else {
                // incorporate error
//                return
//            }
            FileDownloader.loadFileAsync(url: url!) { (path, error,data)  in
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
       // }
    }
    func showLoader() {
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func closeBtn(_ sender: Any) {
        pdfUIView.isHidden = true
        
    }
}


// MARK: - Textfield delegates
extension ViewReportViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let firstColor = UIColor(red: 117/255, green: 148/255, blue: 194/255, alpha: 1.0)
        let secondColor = UIColor(red: 83/255, green: 141/255, blue: 193/255, alpha: 1.0)
        if textField == jobIdTextField {
            jobIDView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            
            jobIDView.applyGradient(colours: [firstColor,secondColor])
            jobIDView.clipsToBounds = true
        }
        else {
            sampleIDView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            sampleIDView.applyGradient(colours: [firstColor,secondColor])
            sampleIDView.clipsToBounds = true
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == jobIdTextField {
            jobIDView.borderColor = .white
            jobIDView.removeGradient()
        }
        else {
            sampleIDView.borderColor = .white
            sampleIDView.removeGradient()
        }
    }
    
}
