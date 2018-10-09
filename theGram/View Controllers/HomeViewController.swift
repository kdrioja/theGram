//
//  LoggedInViewController.swift
//  theGram
//
//  Created by user145766 on 10/6/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse
import ParseLiveQuery

class HomeViewController: UIViewController {

    var client: ParseLiveQuery.Client!
    var subscription: Subscription<Post>!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func fetchPosts() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        query?.findObjectsInBackground(block: { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                print("Retrived last 20 posts!")
                
            }
            else {
                print(error?.localizedDescription)
            }
        })
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
