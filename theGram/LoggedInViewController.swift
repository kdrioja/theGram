//
//  LoggedInViewController.swift
//  theGram
//
//  Created by user145766 on 10/6/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse

class LoggedInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "logInViewController")
                //why wont this work
                //self.window?.rootViewController = loginViewController
            }
        })
        
        
        
        
        
        
        
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
