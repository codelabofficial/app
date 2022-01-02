//
//  setupViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase

class setupViewController: UIViewController {
    
    /*
    // MARK: - IBOutlet Setup
    */
    
    @IBOutlet weak var eyeImageButton: UIButton!
    @IBOutlet weak var eyeImage: UIImageView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var allFieldsMessage: UILabel!
    
    override func viewDidLoad() {
        
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        
        logOutButton.isHidden = true
        allFieldsMessage.isHidden = true
        
        /*
        // MARK: - Check for login
        */
        super.viewDidLoad()
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            fullNameField.isHidden = false
            emailField.isHidden = true
            passwordField.isHidden = true
            loginButton.isHidden = true
            loginLabel.text = "Logged in"
            logOutButton.isHidden = false
            eyeImage.isHidden = true
        }
        

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Visible password button
    */
    
    @IBAction func eyeButtonTouched(_ sender: Any) {
        if passwordField.isSecureTextEntry == true{
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
        
    }
    /*
    // MARK: - Logging out
    */
    
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            try Firebase.Auth.auth().signOut()
            fullNameField.isHidden = true
            emailField.isHidden = false
            passwordField.isHidden = false
            loginLabel.text = "Login"
            logOutButton.isHidden = true
            loginButton.isHidden = false
            eyeImage.isHidden = false
            
            emailField.text = ""
            passwordField.text = ""
           
            
        } catch {
            print("An error occured while signing out")
        }
    }
    
    /*
    // MARK: - Logging in
    */
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        /*
        // MARK: - Check if empty
        */
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
                  print("Make sure both fields are entered")
                  allFieldsMessage.isHidden = false
                  DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                      allFieldsMessage.isHidden = true
                  }
                  return
              }
        
        /*
        
        Attempt sign in, if fails
        tell user to create account
         
        If user continues, create
        account
         
        Check sign in on launch
        to allow sign in without
        button
         
        */
        
        /*
        // MARK: - Attempt login
        */
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                //show account creation message
                strongSelf.showCreateAccount(email: email, password: password)
                return
                
            }
            
            print("Login successful")
            strongSelf.logOutButton.isHidden = false
            strongSelf.loginLabel.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.loginButton.isHidden = true
            strongSelf.logOutButton.isHidden = false
            strongSelf.eyeImage.isHidden = true
        })

    }
    
        /*
        // MARK: - Create account
        */
        
        func showCreateAccount(email: String, password: String) {
            let alert = UIAlertController(title: "No account found", message: "Would you like to create a account?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    guard error == nil else {
                        print("Account creation failed")
                        return
                        
                    }
                    
                    print("Login successful")
                    strongSelf.loginLabel.isHidden = true
                    strongSelf.emailField.isHidden = true
                    strongSelf.passwordField.isHidden = true
                    strongSelf.loginButton.isHidden = true
                    strongSelf.logOutButton.isHidden = false
                    strongSelf.eyeImage.isHidden = true
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            }))
            
            present(alert, animated: true)
        }

}
