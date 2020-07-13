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
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func signup(){
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                let homePVC = RootPageViewController()
                self.present(homePVC, animated: true, completion: nil)
            }
        })
    }
    
    func setupProfile(){
        //TODO: Create user profile
    }

    @IBAction func signupBtn(_ sender: Any) {
        signup()
    }
}
