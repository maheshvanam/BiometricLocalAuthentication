//
//  ViewController.swift
//  FaceIdSample
//
//  Created by admin on 23/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showMessage(){
        let vc = storyboard?.instantiateViewController(identifier: Util.Storyboards.secondViewController)
        show(vc!, sender: nil)
    }
    
    @IBAction func didAuthenticateTapped(_ sender: Any) {
        authenticate()
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: Util.Strings.reason) { [weak self](success, error) in
                DispatchQueue.main.async {
                    if success {
                        self?.showMessage()
                    }
                    else{
                        self?.showAlert(title: Util.Strings.authentionErrorMessage, message: error?.localizedDescription ?? Util.Strings.authentionErrorMessage)
                    }
                }
            }
        }
        else {
            
            self.showAlert(title: error?.localizedFailureReason ?? Util.Strings.biometryErrorTitle, message: error?.localizedDescription ?? Util.Strings.biometryErrorMessage )
        }
    }
    
    func showAlert(title:String,message:String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Util.Strings.titleOk, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

