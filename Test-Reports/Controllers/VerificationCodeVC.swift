//
//  VerificationCodeVC.swift
//  QRI App
//
//  Created by Mazhar on 01/06/2021.
//

import UIKit
import Spring
class VerificationCodeVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var codeView: DesignableView!
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCode.delegate = self
        txtCode.attributedPlaceholder = NSAttributedString(string: "Verification Code",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

    }
    // MARK: - Button Actions
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - Textfield delegates
extension VerificationCodeVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let firstColor = UIColor(red: 117/255, green: 148/255, blue: 194/255, alpha: 1.0)
        let secondColor = UIColor(red: 83/255, green: 141/255, blue: 193/255, alpha: 1.0)
        if textField == txtCode {
            codeView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            codeView.applyGradient(colours: [firstColor,secondColor])
            codeView.clipsToBounds = true
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == txtCode {
            codeView.borderColor = .white
            codeView.removeGradient()
        }
    }
    
}
