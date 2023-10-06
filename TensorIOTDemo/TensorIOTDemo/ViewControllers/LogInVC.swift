//
//  ViewController.swift
//  TensorIOTDemo
//
//  Created by IOSTEAM02 on 05/10/23.
//

import UIKit

class LogInVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Variables
    let authViewModel = AuthenticationViewModel()
    let loader = Indicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Login to your app"
    }
    
    //Funtions
    func validation(_ completion: @escaping() -> ()) {
        var alert = UIAlertController()
        if emailTextField.text == "", passwordTextField.text == ""{
            alert = UIAlertController(title: "Alert", message: "Please fill all the fields", preferredStyle: UIAlertController.Style.alert)
        } else {
            completion()
            return
        }
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Actions
    @IBAction func logInAction(_ : UIButton) {
        validation {
            self.loader.showIndicator(self)
            self.authViewModel.logInApi(self.emailTextField.text ?? "", self.passwordTextField.text ?? "") { string, error in
                if string == "success" {
                    self.loader.stopIndicator()
                    debugPrint("Login Success")
                } else {
                    self.loader.stopIndicator()
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription ?? "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func signUpAction(_ : UIButton) {
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }

}

