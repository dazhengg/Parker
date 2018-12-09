//
//  Takepicture.swift
//  Parker
//
//  Created by lihang pan on 2018/11/17.
//  Copyright © 2018 Zekai Zhao. All rights reserved.
//

import Foundation
import UIKit

class takepictureViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagetake: UIImageView!
    var imagePicker: UIImagePickerController!
    enum ImageSource {
        case photoLibrary
        case camera
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		if let previousImage = ImageStorage.ParkingImage{
			imagetake.image = previousImage
		}
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        downSwipe.direction = .down
        self.view.addGestureRecognizer(downSwipe)
    }
	
	
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        if sender.state == .ended{
            dismiss(animated: true)
        }
    }
    
    @IBAction func takepicture(_ sender: UIButton) {
    
		guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
				selectImageFrom(.photoLibrary)
				return
		}
        selectImageFrom(.camera)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func save(_ sender: Any) {
    
        guard let selectedImage = imagetake.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension takepictureViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imagetake.image = selectedImage
		ImageStorage.ParkingImage = selectedImage
		print("pass")
    }
}
