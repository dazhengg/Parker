//
//  SettingViewController.swift
//  Parker
//
//  Created by Haoran Zhang on 11/17/18.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var NavBar: UINavigationItem!
    @IBOutlet weak var BarButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        NavBar.title = "Setting"
        BarButtonItem.title = "Back"
    }
    
    @IBAction func GoBackToMapVC(_ sender: Any) {
        //why my commits is not showing
        self.dismiss(animated: true, completion: nil)
    }
    
}
