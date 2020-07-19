//
//  LoginViewController.swift
//  testing_MC_IC041717
//
//  Created by AJ on 7/18/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var googleSigninBtn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid != nil {
            goToHome()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print(error)
        return
      }
        print("Signed into google successfully")


      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential)  { (user, error) in
            if let error = error {
                print (error.localizedDescription)
                return
            }
            print("Signed into Firebase successfully")
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion:  { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            self.goToHome()
        })
    }
    
    func goToHome(){
        let homePVC = RootPageViewController()
        self.present(homePVC, animated: true, completion: nil)
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        login()
    }
    
    @IBAction func googleSigninBtn(_ sender: Any) {
    }
    
    
}
