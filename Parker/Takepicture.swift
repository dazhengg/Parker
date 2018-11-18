//
//  Takepicture.swift
//  Parker
//
//  Created by lihang pan on 2018/11/17.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation
import UIKit

class takepictureViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        downSwipe.direction = .down
        self.view.addGestureRecognizer(downSwipe)
    }
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vb = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            self.present(vb, animated: false, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
