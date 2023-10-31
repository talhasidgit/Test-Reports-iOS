//
//  ResetPasswordVC.swift
//  QRI App
//
//  Created by Mazhar on 28/06/2021.
//

import UIKit
import Spring
import IQKeyboardManagerSwift
import TransitionButton
enum securePasswordOptions:Int {
    case oldPassword = 0
    case newPassword
    case confirmNewPassword
}

class ResetPasswordVC: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var btnResetPassword: TransitionButton!
    @IBOutlet weak var oldPasswordView: DesignableView!
    @IBOutlet weak var newPasswordView: DesignableView!
    @IBOutlet weak var confirmPasswordView: DesignableView!
    @IBOutlet weak var confirmChangesView: DesignableView!
    
    @IBOutlet var oldPasswordTxt: UITextField!
    @IBOutlet var newPasswordTxt: UITextField!
    @IBOutlet var confirmPasswordTxt: UITextField!
    // MARK: - Variables
    var securePassword = false
    var newSecurePassword = false
    var confirmSecurePassword = false
    
    // MARK: - View Lifecycles
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    // MARK: - Button Actions
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnConfirmChangesPressed(_ sender: Any) {
        checkValidations()
    }
    @IBAction func eyeBtnPressed(_ sender: UIButton) {
        if sender.tag == securePasswordOptions.oldPassword.rawValue {
            if securePassword {
                oldPasswordTxt.isSecureTextEntry = false
                sender.setImage(UIImage(named: "hide_password"), for: .normal)
            }
            else {
                oldPasswordTxt.isSecureTextEntry = true
                sender.setImage(UIImage(named: "show_password"), for: .normal)
            }
            securePassword = !securePassword
        }
        else if sender.tag == securePasswordOptions.newPassword.rawValue {
            if newSecurePassword {
                newPasswordTxt.isSecureTextEntry = false
                sender.setImage(UIImage(named: "hide_password"), for: .normal)
            }
            else {
                newPasswordTxt.isSecureTextEntry = true
                sender.setImage(UIImage(named: "show_password"), for: .normal)
            }
            newSecurePassword = !newSecurePassword
        }
        else {
            if confirmSecurePassword {
                confirmPasswordTxt.isSecureTextEntry = false
                sender.setImage(UIImage(named: "hide_password"), for: .normal)
            }
            else {
                confirmPasswordTxt.isSecureTextEntry = true
                sender.setImage(UIImage(named: "show_password"), for: .normal)
            }
            confirmSecurePassword = !confirmSecurePassword
        }
        
    }
    // MARK: -  Functions
    
    func setUpViews()  {
        
        oldPasswordTxt.attributedPlaceholder = NSAttributedString(string: "Old Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        newPasswordTxt.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        confirmPasswordTxt.attributedPlaceholder = NSAttributedString(string: "Confirm New Password",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        let redColor = UIColor(red: 232/255, green: 169/255, blue: 46/255, alpha: 1.0)
        let yellowColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
        confirmChangesView.applyGradient(colours: [redColor,yellowColor])
        confirmChangesView.layer.cornerRadius = 25
        confirmChangesView.clipsToBounds = true
        oldPasswordTxt.delegate = self
        newPasswordTxt.delegate = self
        confirmPasswordTxt.delegate = self
    }
    func checkValidations()  {
        if oldPasswordTxt.text == "" {
            Commons.showAlert(msg: "Old pssword is required")
            
            return
        }
        if newPasswordTxt.text == "" {
            Commons.showAlert(msg: "New Password is required")
            return
        }
        if confirmPasswordTxt.text == "" {
            Commons.showAlert(msg: "Confirm new Password is required")
            return
        }
        if newPasswordTxt.text?.count ?? DefaultValue.int < 6 || confirmPasswordTxt.text?.count ?? DefaultValue.int < 6 {
            Commons.showAlert(msg: "Password must be atleast 6 characters long")
            return
        }
        if newPasswordTxt.text?.count != confirmPasswordTxt.text?.count {
            Commons.showAlert(msg: "New Password and Confirm Password should match")
            return
        }
        resetPassword()
    }
    func resetPassword()  {
        btnResetPassword.startAnimation()
        let resetPasswordVm = ResetPasswordViewModel()
        var userId = 0
        if  let uID = defaults.object(forKey: kUserId)  {
            userId = uID as! Int
        }
        let params = ["old_password":oldPasswordTxt.text!,"new_password":newPasswordTxt.text!,"confirm_password":confirmPasswordTxt.text!,"user_id":userId,"token":defaults.object(forKey: kUserToken) ?? DefaultValue.string] as [String : Any]
        resetPasswordVm.ResetPasswordApi(params: params) { [weak self](resp ) in
            self?.btnResetPassword.stopAnimation()
            switch resp {
            case .success(let resp):
                print(resp)
                if resp.status ?? DefaultValue.bool {
                    defaults.set(nil, forKey: kUserToken)
                    Commons.transitionToLoginScreen()
                    Commons.showToast(msg: resp.message ?? "Password updated successfully!")
                }
                else {
                    Commons.showErrorAlert(msg: resp.message ?? "Something went wrong!")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
// MARK: - Textfield delegates
extension ResetPasswordVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let firstColor = UIColor(red: 117/255, green: 148/255, blue: 194/255, alpha: 1.0)
        let secondColor = UIColor(red: 83/255, green: 141/255, blue: 193/255, alpha: 1.0)
        if textField == oldPasswordTxt {
            oldPasswordView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            
            oldPasswordView.applyGradient(colours: [firstColor,secondColor])
            oldPasswordView.clipsToBounds = true
        }
        else if textField == newPasswordTxt{
            newPasswordView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            newPasswordView.applyGradient(colours: [firstColor,secondColor])
            newPasswordView.clipsToBounds = true
        }
        else {
            confirmPasswordView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            confirmPasswordView.applyGradient(colours: [firstColor,secondColor])
            confirmPasswordView.clipsToBounds = true
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == oldPasswordTxt {
            oldPasswordView.borderColor = .white
            oldPasswordView.removeGradient()
        }
        else if textField == newPasswordTxt {
            newPasswordView.borderColor = .white
            newPasswordView.removeGradient()
        }
        else {
            confirmPasswordView.borderColor = .white
            confirmPasswordView.removeGradient()
        }
    }
}
