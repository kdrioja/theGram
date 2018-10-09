//
//  CreatePostViewController.swift
//  theGram
//
//  Created by user145766 on 10/9/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTakePhoto(_ sender: Any) {
        errorLabel.text = ""
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available!")
            vc.sourceType = UIImagePickerController.SourceType.camera
        }
        else {
            vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func onSelectPhoto(_ sender: Any) {
        errorLabel.text = ""
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = false
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func onShare(_ sender: Any) {
        if photoImageView.image != nil {
            //Upload photo to Parse
            Post.postUserImage(image: photoImageView.image, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
                if success {
                    print("Post shared successfully!")
                }
                else {
                    print("Failed to post, error: \(error?.localizedDescription)")
                }
            }
            
            //Go back to the HomeViewController
            dismiss(animated: true, completion: nil)
        }
        else {
            errorLabel.text = "Select photo to share"
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photoPicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //Fill the photoImageView
        self.photoImageView.image = photoPicked
        
        dismiss(animated: true, completion: nil)
    }
}
