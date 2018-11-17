//
//  swipe.swift
//  crypto_currency_wallet
//
//  Created by lihang pan on 2018/11/14.
//  Copyright © 2018年 lihang pan. All rights reserved.
//

import Foundation
import UIKit

class swipeViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)*/
        
        
        /*let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        upSwipe.direction = .up
        self.view.addGestureRecognizer(upSwipe)*/


        
        //self.view.addGestureRecognizer(rightSwipe)
                
        
    
    }
    

    /*@objc func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        view.frame.origin = translation
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.y >= 1000{
                //dismiss the view
                self.dismiss(animated: true, completion: nil)
            }else{
                //return the origin one
                
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame.origin = CGPoint(x:0, y:0)
                })
                
            }
        }
    }*/
    /*@objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vb = storyboard.instantiateViewController(withIdentifier: "loginviewController") as! LoginViewController
                self.present(vb, animated: true, completion: nil)
           
        }

            

        
            
        
            
    }*/

    
    
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



