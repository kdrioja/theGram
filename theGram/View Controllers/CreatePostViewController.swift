//
//  CreatePostViewController.swift
//  theGram
//
//  Created by user145766 on 10/9/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class CreatePostViewController: UIViewController {

    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTakePhoto(_ sender: Any) {
    }
    
    
    @IBAction func onSelectPhoto(_ sender: Any) {
    }
    
    
    @IBAction func onShare(_ sender: Any) {
        //Upload photo to Parse
        
        //Go back to the HomeViewController
        dismiss(animated: true, completion: nil)
    }
    
    

}
