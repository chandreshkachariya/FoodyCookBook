//
//  ImagePickerManager.swift
//  eOPD Doctor
//
//  Created by Chandresh Kachariya on 20/12/19.
//  Copyright © 2019 Chandresh Kachariya. All rights reserved.
//

import UIKit
import MobileCoreServices

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose action", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
    var pickVideoCallback : ((URL) -> ())?;

    override init(){
        super.init()
    }
    
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;
        self.picker.allowsEditing = false

        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.viewController!.view.bounds.midX, y: self.viewController!.view.bounds.midY, width: 0, height: 0)
        alert.popoverPresentationController?.permittedArrowDirections = []

        viewController.present(alert, animated: true, completion: nil)
    }
    func pickImageVideo(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ()), _ callbackVideo: @escaping ((URL) -> ())) {
        pickImageCallback = callback;
        pickVideoCallback = callbackVideo;
        self.viewController = viewController;
        self.picker.allowsEditing = false

        let cameraAction = UIAlertAction(title: "Image from Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Image from Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cameraActionVideo = UIAlertAction(title: "Video from Camera", style: .default){
            UIAlertAction in
            self.openCameraVideo()
        }
        let gallaryActionVideo = UIAlertAction(title: "Video from Gallery", style: .default){
            UIAlertAction in
            self.openGalleryVideo()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cameraActionVideo)
        alert.addAction(gallaryActionVideo)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
            
//            picker.dismiss(animated: true, completion: nil)
            
        } else {
            viewController!.showToast(message: "You don't have camera", delay: 2.0)
            /*let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()*/
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    
    }
    
    func openCameraVideo(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            picker.mediaTypes = [kUTTypeMovie as String]
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    
    func openGalleryVideo(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeMovie as String]
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as AnyObject
        
        if mediaType as! String == kUTTypeMovie as String {
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            print("VIDEO URL: \(videoURL!)")
            picker.dismiss(animated: true, completion: nil)
            pickVideoCallback?(videoURL!)
        }else {
            guard let image = info[.originalImage] as? UIImage else { return }
            delay(bySeconds: 0.5) {
                self.pickImageCallback?(image)
            }
            
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        
    }
    
}
