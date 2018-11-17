//
//  ViewController.swift
//  crypto_currency_wallet
//
//  Created by lihang pan on 2018/10/3.
//  Copyright © 2018年 lihang pan. All rights reserved.
//

import UIKit
//import libPhoneNumber_iOS
import MobileCoreServices
import Photos


class LoginViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var pic: UIImageView!
    
    var imagePickerController:UIImagePickerController!
    var chosenImage: UIImage!
        
        override func viewDidLoad() {
            super.viewDidLoad()
    

            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(panGestureRecognizer)
            
            
    }
    @objc func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer){
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
    }
   


    
    
            
    /*@IBAction func leftswipe(_ sender: UISwipeGestureRecognizer) {
        self.lbl.text = "swiped left"
    }
    
    @IBAction func rightswipe(_ sender: UISwipeGestureRecognizer) {
        self.lbl.text = "swiped right"
    }*/
    
            //判断是否获得相机
    
    
        
        //delegate方法
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        print("user canceled the camera")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerEditedImage]
        self.pic!.image = (chosenImage as! UIImage)
        self.dismiss(animated: true, completion: nil)
        print("user canceled the camera")
    }
        /*func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            let dic = info as NSDictionary
            //原始图片
            let image = dic.object(forKey: "UIImagePickerControllerOriginalImage") as! UIImage
            //编辑过后的图片
            let editedImage = dic.object(forKey: "UIImagePickerControllerEditedImage") as! UIImage
            //MediaType
            let mediaType = dic.object(forKey: "UIImagePickerControllerMediaType") as! String
        }
        
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            
        }*/
        


 
    
   
    @IBAction func takepicture(_ sender: Any) {
        /*if ((UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.camera)) != nil) {
            //初始化
            imagePickerController = UIImagePickerController()
            //设置代理
            imagePickerController.delegate = self;
            //设置类型
            imagePickerController.sourceType = .camera
            //设置是否能够编辑
            imagePickerController.allowsEditing = true
            //展示UIImagePickerController
            self.present(imagePickerController, animated: true, completion: {})
        }*/
        imagePickerController = UIImagePickerController()
        //设置代理
        imagePickerController.delegate = self;
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePickerController.sourceType)!
        self.present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


