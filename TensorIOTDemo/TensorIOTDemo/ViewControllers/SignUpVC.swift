//
//  SignUpVC.swift
//  TensorIOTDemo
//
//  Created by IOSTEAM02 on 05/10/23.
//

import Foundation


import UIKit

class SignUpVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var confirmPasswordTextField : UITextField!
    @IBOutlet weak var userNameTextField : UITextField!
    @IBOutlet weak var detailsTextField : UITextField!
    @IBOutlet weak var profileImage : UIImageView!
    
    //Variables
    let authViewModel = AuthenticationViewModel()
    let loader = Indicator()
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rightButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(self.selectProfileImage))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.title = "Register"
    }
    
    //Funtions
    func validation(_ completion: @escaping() -> ()) {
        var alert = UIAlertController()
        if emailTextField.text == "", passwordTextField.text == "", confirmPasswordTextField.text == "", userNameTextField.text == "", detailsTextField.text == "" {
            alert = UIAlertController(title: "Alert", message: "Please fill all the fields", preferredStyle: UIAlertController.Style.alert)
        } else if (passwordTextField.text != nil) == (confirmPasswordTextField.text == nil) {
            alert = UIAlertController(title: "Alert", message: "Password and Confirm Password should be match", preferredStyle: UIAlertController.Style.alert)
        } else if profileImage.image == UIImage(systemName: "person.fill") {
            alert = UIAlertController(title: "Alert", message: "Select Profile Image", preferredStyle: UIAlertController.Style.alert)
        }else {
            completion()
            return
        }
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }

    //Actions
    @IBAction func signUpAction(_ : UIButton) {
        self.validation {
            self.loader.showIndicator(self)
            self.authViewModel.registerationApi(self.emailTextField.text ?? "", self.passwordTextField.text ?? "") { string, error in
                if string == "success" {
                    self.loader.stopIndicator()
                    let alert = UIAlertController(title: "Alert", message: "Registration Complete!!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                        let profileVc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                        profileVc.profile = self.profileImage.image
                        profileVc.nameText = self.userNameTextField.text ?? ""
                        profileVc.detailText = self.detailsTextField.text ?? ""
                        self.navigationController?.pushViewController(profileVc, animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.loader.stopIndicator()
                    let alert = UIAlertController(title: "Alert", message: error.debugDescription , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func selectProfileImage(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }

}

extension SignUpVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        self.profileImage.image = info[.originalImage] as? UIImage
    }
}
