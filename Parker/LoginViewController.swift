//
//  LoginViewController.swift
//  Parker
//
//  Created by David Zheng on 11/30/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
class LoginViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate  {
    var name: String = ""
   //  var appsetting = AppSettings()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBOutlet weak var anon_user: UITextField!

    @IBAction func anon_auth(_ sender: Any) {
        guard let name = anon_user.text, !name.isEmpty else {
            return
        }
        AppSettings.displayName = name
        anon_user.resignFirstResponder()
        Auth.auth().signInAnonymously() { (authResult, error) in
            if error == nil {
                let user = authResult?.user
                let isAnonymous = user?.isAnonymous  // true
                let uid = user?.uid
                let 
                
            }
       
        }
}

        
       

    
    


//    handleAppState() {
//    Auth.auth().signInAnonymously(completion: nil)
//    if let user = Auth.auth().currentUser {
//    let vc = ChannelsViewController(currentUser: user)
//    rootViewController = NavigationController(vc)
//    } else {
//    rootViewController = LoginViewController()
//    }
//    }
//
//    private func signIn() {
//        guard let name = displayNameField.text, !name.isEmpty else {
//            showMissingNameAlert()
//            return
//        }
//
//        displayNameField.resignFirstResponder()
//
//        AppSettings.displayName = name
//        Auth.auth().signInAnonymously(completion: nil)
//    }

}
