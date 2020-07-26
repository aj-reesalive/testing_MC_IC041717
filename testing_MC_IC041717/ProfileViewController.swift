//
//  ProfileViewController.swift
//  testing_MC_IC041717
//
//  Created by AJ on 7/25/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var displayNameText: UILabel!
    
    var databaseRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
        
        if let userID = Auth.auth().currentUser?.uid{
            print(userID)
            
            databaseRef.child("profile").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let dictionary = snapshot.value as? NSDictionary
                
                //let username = dictionary?["username"] as? String?? "username"
                
                let username = dictionary!["username"]
                
                if let profileImageURL = dictionary?["photo"] as? String {
                    
                    let url = URL (string: profileImageURL)
                    
                    URLSession.shared.dataTask(with: url!, completionHandler:  { (data, response, error) in
                        
                        if error != nil {
                            print(error!)
                            return
                        }
                        DispatchQueue.main.async{
                            self.profileImageView.image = UIImage(data: data!)
                        }
                    }).resume()
                }
                self.usernameText.text = username as? String
                self.displayNameText.text = username as? String
            }) { (error) in
                print(error.localizedDescription)
                return
            }
        }
    }
}
