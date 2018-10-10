//
//  LoggedInViewController.swift
//  theGram
//
//  Created by user145766 on 10/6/18.
//  Copyright © 2018 Kenia Rioja. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import ParseLiveQuery

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var client: ParseLiveQuery.Client!
    var subscription: Subscription<Post>!
    var posts: [Post] = []
    var refreshTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Tap gesture recognizer
        //let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        //self.view.addGestureRecognizer(gestureRecognizer)
        
        //Pull to refresh function
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPosts(_:)), for: UIControl.Event.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.rowHeight = 475
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        
        
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {_ in}))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = posts[indexPath.row]
        cell.usernameLabel.text = post.author.username
        cell.captionLabel.text = post.caption
        cell.photoPFImageView.file = post.media //PFFile is returned
        cell.photoPFImageView.loadInBackground()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    @objc func fetchPosts(_ refreshControl: UIRefreshControl) {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        query?.findObjectsInBackground(block: { (posts: [PFObject]?, error: Error?) in
            if posts != nil {
                print("Retrived last 20 posts!")
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                refreshControl.endRefreshing()
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
