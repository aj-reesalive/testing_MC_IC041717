//
//  SignupViewController.swift
//  testing_MC_IC041717
//
//  Created by AJ on 7/12/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import Firebase


class SignupViewController: UIViewController {
    
    var databaseRef: DatabaseReference!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    func signup(email: String, password:String){
        
        
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (authResult, error) in

            if error != nil {
                print(error!)
                return
                
            }else {
                
                let result = authResult!
                self.createProfile(result.user)
                let homePVC = RootPageViewController()
                self.present(homePVC, animated: true, completion: nil)
            }
        })
    }
    
    func createProfile(_ user: User){
        let delimiter = "@"
        let email = user.email
        let uName = email?.components(separatedBy: delimiter)
        
        let newUser = ["username": uName?[0],
                       "email": user.email,
                       "photo":"https://firebasestorage.googleapis.com/v0/b/reesa-login-swiftfirebase.appspot.com/o/504-5040528_empty-profile-picture-png-transparent-png.png?alt=media&token=5b26878e-e868-46aa-9c3e-9af86bbda332"] as [String : Any]
        
        self.databaseRef.child("profile").child(user.uid).updateChildValues(newUser){ (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            print("Profile sucessfully created")
        }
        
    }
    
    func setupProfile(){
        //TODO: Create user profile
    }

    @IBAction func signupBtn(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        signup(email: email, password: password)
    }
}
