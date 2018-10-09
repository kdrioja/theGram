//
//  LogInViewController.swift
//  theGram
//
//  Created by user145766 on 10/2/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.errorLabel.text = "   "
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("You're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                if error?._code == 101 {
                    self.errorLabel.text = "Invalid username/password"
                }
            }
        }
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Yay, created a user!")
                print("You're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            } else {
                print(error?.localizedDescription)
                
                if error?._code == 202 {
                    print("Username is already taken.")
                    self.errorLabel.text = "Username already taken"
                }
            }
        }
    }
}
