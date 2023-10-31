//
//  ForgotPasswordVC.swift
//  QRI App
//
//  Created by Mazhar on 01/06/2021.
//

import UIKit
import Spring
import TransitionButton
class ForgotPasswordVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var recoverAccountView:
        DesignableView!
    
    @IBOutlet weak var btnRecoverAccount: TransitionButton!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet weak var emailView: DesignableView!
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        let redColor = UIColor(red: 232/255, green: 169/255, blue: 46/255, alpha: 1.0)
        let yellowColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
        recoverAccountView.applyGradient(colours: [redColor,yellowColor])
        recoverAccountView.layer.cornerRadius = 25
        recoverAccountView.clipsToBounds = true
        emailTxt.delegate = self
        
    }
    // MARK: - Button Actions
    
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRecoverAccountPressed(_ sender: UIButton) {
        self.checkValidations()
    }
    
    // MARK: - Functions
    
    func checkValidations()  {
        if emailTxt.text == "" {
            Commons.showAlert(msg: "Email is required")
            return
        }
        if !emailTxt.text!.isValidEmail() {
            Commons.showAlert(msg: "Invalid emil")
            return
        }
        self.forgotPassword()
    }
    func forgotPassword()  {
        btnRecoverAccount.startAnimation()
        let forgotPasswordVm = ForgotPasswordViewModal()
        let params = ["email":emailTxt.text!]
        forgotPasswordVm.ForgotPasswordApi(params: params) {[weak self] (resp) in
            self?.btnRecoverAccount.stopAnimation()
            switch resp {
            case .success(let resp):
                print(resp)
                self?.emailTxt.text = ""
                let alert = UIAlertController(title: "QRI", message: "Reset password link has been sent on your email id. Please reset your password and login again.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self?.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                self?.present(alert, animated: true, completion: nil)
                
            case .failure(let error):
                Commons.showErrorAlert(msg: error.localizedDescription)
            }
        }
        
    }
}
// MARK: - Textfield delegates
extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let firstColor = UIColor(red: 117/255, green: 148/255, blue: 194/255, alpha: 1.0)
        let secondColor = UIColor(red: 83/255, green: 141/255, blue: 193/255, alpha: 1.0)
        if textField == emailTxt {
            emailView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            emailView.applyGradient(colours: [firstColor,secondColor])
            emailView.clipsToBounds = true
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == emailTxt {
            emailView.borderColor = .white
            emailView.removeGradient()
        }
    }
    
}
