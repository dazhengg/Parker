//
//  SettingViewController.swift
//  Parker
//
//  Created by Haoran Zhang on 11/17/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITextFieldDelegate {

   
    @IBOutlet weak var input_act: UITextField!
    @IBOutlet weak var input_num: UITextField!
    
  
    
    @IBOutlet weak var NavBar: UINavigationItem!
    @IBOutlet weak var BarButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        NavBar.title = "Setting"
        BarButtonItem.title = "Back"
        input_act.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x_act = UserDefaults.standard.object(forKey: "act_name") as? String {
            input_act.text = x_act
        }
        if let y_num = UserDefaults.standard.object(forKey: "act_number") as? String {
            input_num.text = y_num
        }
    }
    
    @IBAction func store_act(_ sender: Any) {
       User.userName = input_act.text


    }
    @IBAction func store_num(_ sender: Any) {
      User.number =  input_num.text
        
    }
    
    
    
    @IBAction func GoBackToMapVC(_ sender: Any) {
        //why my commits is not showing
        self.dismiss(animated: true, completion: nil)
    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        user.userName = input_act.text
//        return false
//
//    }

}
