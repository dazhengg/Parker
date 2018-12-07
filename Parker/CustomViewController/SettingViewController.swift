//
//  SettingViewController.swift
//  Parker
//
//  Created by David Zheng on 11/17/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITextFieldDelegate {

   
 
    @IBOutlet weak var input_num: UITextField!
    
  
    
    @IBOutlet weak var NavBar: UINavigationItem!
//    @IBOutlet weak var BarButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        NavBar.title = "Set Plate Number (Optional)"
//        BarButtonItem.title = "Back"
        input_num.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
        if let y_num = UserDefaults.standard.object(forKey: "act_number") as? String { // plate #
            input_num.text = y_num
        }
    }
    
 
    @IBAction func store_num(_ sender: Any) {
      User.number =  input_num.text
        
    }
    
    
    
//    @IBAction func GoBackToMapVC(_ sender: Any) {
//
//        self.dismiss(animated: true, completion: nil)
//    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        user.userName = input_act.text
//        return false
//
//    }

}
