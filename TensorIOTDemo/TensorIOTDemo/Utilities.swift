//
//  Utilities.swift
//  TensorIOTDemo
//
//  Created by IOSTEAM02 on 05/10/23.
//

import Foundation
import UIKit

class Indicator {
    
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    func showIndicator(_ vc: UIViewController) {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func stopIndicator(){
        alert.dismiss(animated: true)
    }
}
