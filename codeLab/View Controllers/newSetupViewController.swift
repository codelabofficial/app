//
//  newSetupViewController.swift
//  codeLab
//
//  Created by Alfie on 02/01/2022.
//

import UIKit
import Firebase

class newSetupViewController: UIViewController {
    
    /*
    // MARK: - IBOutlet Setup
    */

    @IBOutlet weak var loggedInMessage: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var allFieldsMessage: UILabel!
    @IBOutlet weak var eyeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        firstNameField.autocorrectionType = .no
        firstNameField.autocapitalizationType = .none
        
        allFieldsMessage.isHidden = true
        loggedInMessage.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Password visibility
    */
    
    @IBAction func passwordVisibleButton(_ sender: Any) {
        if passwordField.isSecureTextEntry == true{
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        let name = firstNameField.text
        
        /*
        // MARK: - Check if empty
        */
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let firstName = firstNameField.text, !firstName.isEmpty else {
                  print("Make sure all fields are entered")
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
            strongSelf.loginLabel.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.eyeImage.isHidden = true
            strongSelf.firstNameField.isHidden = true
            strongSelf.continueButton.isHidden = true
            strongSelf.loggedInMessage.isHidden = false
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
                strongSelf.eyeImage.isHidden = true
                strongSelf.firstNameField.isHidden = true
                strongSelf.continueButton.isHidden = true
                strongSelf.loggedInMessage.isHidden = false
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
        }))
        
        present(alert, animated: true)
    }

}
