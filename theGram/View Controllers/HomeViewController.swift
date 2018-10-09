//
//  LoggedInViewController.swift
//  theGram
//
//  Created by user145766 on 10/6/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onCreatePost(_ sender: Any) {
        
        //edit this code below to transition to CreatePostViewController
        self.performSegue(withIdentifier: "createPostSegue", sender: nil)

        
    }
    
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                
                
                // Load and show the login view controller
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "logInViewController") as! LogInViewController
                self.present(loginViewController, animated: true, completion: nil)
                
            }
        })
    }
}
