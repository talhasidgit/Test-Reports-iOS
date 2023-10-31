//
//  ProfileVC.swift
//  QRI App
//
//  Created by Mazhar on 25/06/2021.
//

import UIKit
import Spring
import IQKeyboardManagerSwift
import SDWebImage
class ProfileVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var firstNameView: DesignableView!
    @IBOutlet weak var lastNameView: DesignableView!
    @IBOutlet weak var emailView: DesignableView!
    @IBOutlet var changePasswordView: DesignableView!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var firstNameTxt: UITextField!
    @IBOutlet var lastNameTxt: UITextField!
    //MARK: - Variables
    var picker = UIImagePickerController()
    var actionSheet = UIAlertController()

    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        showData()
    }
    func openImageBottomSheet()  {
        actionSheet = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        // Add the actions
        picker.delegate = self
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Button Actions
    @IBAction func btnBackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnPickImagePressed(_ sender: Any) {
        openImageBottomSheet()
    }
    @IBAction func btnResetPasswordPressed(_ sender: Any) {
        let vc = allStoryBoards.ResetPasswordVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    // MARK: -  Functions
    func showData()  {
        if  let email = defaults.object(forKey: kEmail)  {
            self.emailTxt.text = email as? String
        }
        if  let name = defaults.object(forKey: kUserName)  {
            self.firstNameTxt.text = name as? String
        }
        if  let profileImage = defaults.object(forKey: kUserProfile)  {
            profileImg.sd_setImage(with: URL(string: "\(profileImage)"), placeholderImage: UIImage(named: "user_placeholder"), options: .refreshCached, context: nil)
        }
    }
    
    func setUpViews()  {
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        firstNameTxt.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTxt.isUserInteractionEnabled = false
        firstNameTxt.isUserInteractionEnabled = false
        // lastNameTxt.attributedPlaceholder = NSAttributedString(string: "Last Name",
        //                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        let redColor = UIColor(red: 232/255, green: 169/255, blue: 46/255, alpha: 1.0)
        let yellowColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
        changePasswordView.applyGradient(colours: [redColor,yellowColor])
        changePasswordView.layer.cornerRadius = 25
        changePasswordView.clipsToBounds = true
        emailTxt.delegate = self
        firstNameTxt.delegate = self
        // lastNameTxt.delegate = self

    }
    func uploadImage(img:UIImage) {
        let data = img.jpeg(.low)
        let imageSize: Int = data!.count
        print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
        var userId = 0
        let imgSize = Double(imageSize) / 1000.0
        if imgSize > 10000 {
            Commons.showErrorAlert(msg: "Image size is too high!")
            return

        }
        profileImg.image = img
        if  let uID = defaults.object(forKey: kUserId)  {
            userId = uID as! Int
        }
        let params = ["user_id":"\(userId)","token":defaults.object(forKey: kUserToken) ?? DefaultValue.string] as [String : Any]
        let vm = UploadImageViewModel()
        vm.uploadImageApi(params: params, imgData: data!, key: "profile_image") { (resp) in
            switch resp {
            case .success(let resp):
                print(resp)
                if resp.status ?? DefaultValue.bool  {
                    if let profile = resp.data?.profileImage {
                        defaults.set(profile, forKey: kUserProfile)
                        Commons.showToast(msg: "Image uploaded successfully!")
                    }
                    
                }
                else {
                    print("something went wrong!")
                }
                
            case .failure(let error):
                Commons.showErrorAlert(msg: error.localizedDescription)
            }
        }
    
    }
    
}
// MARK: - Textfield delegates
extension ProfileVC: UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let firstColor = UIColor(red: 117/255, green: 148/255, blue: 194/255, alpha: 1.0)
        let secondColor = UIColor(red: 83/255, green: 141/255, blue: 193/255, alpha: 1.0)
        if textField == emailTxt {
            emailView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            
            emailView.applyGradient(colours: [firstColor,secondColor])
            emailView.clipsToBounds = true
        }
        else if textField == firstNameTxt{
            firstNameView.borderColor = UIColor(red: 234/255, green: 194/255, blue: 95/255, alpha: 1.0)
            firstNameView.applyGradient(colours: [firstColor,secondColor])
            firstNameView.clipsToBounds = true
        }
       
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == emailTxt {
            emailView.borderColor = .white
            emailView.removeGradient()
        }
        else if textField == firstNameTxt {
            firstNameView.borderColor = .white
            firstNameView.removeGradient()
        }
       
    }
    //MARK: - image delegete methods
    
    func openCamera(){
        actionSheet.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            self.present(alertController, animated: true)
        }
    }
    func openGallery(){
        actionSheet.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
            
        }
        self.uploadImage(img: image)
        
    }
    
}
