//
//  AuthenticationViewModel.swift
//  TensorIOTDemo
//
//  Created by IOSTEAM02 on 05/10/23.
//

import Foundation
import FirebaseAuth

struct AuthenticationViewModel {
    
    func registerationApi(_ email: String,_ password: String, completion: @escaping(String?,Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                debugPrint("registraion success \(authResult))")
                completion("success", nil)
            } else {
                debugPrint(error ?? Error.self)
                completion(nil, error)
            }
        }
    }
    
    func logInApi(_ email: String,_ password: String, completion: @escaping(String?,Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil {
                debugPrint("Login success \(authResult))")
                completion("success", nil)
            } else {
                debugPrint((error! as NSError))
                completion(nil, error)
            }
        }
    }
    
}
