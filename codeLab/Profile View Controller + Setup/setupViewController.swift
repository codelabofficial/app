//
//  setupViewController.swift
//  codeLab
//
//  Created by Alfie on 02/01/2022.
//

import UIKit
import Firebase
import FirebaseFirestore

class setupViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    /*
    // MARK: - IBOutlet Setup
    */

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
        firstNameField.autocapitalizationType = .words
        
        allFieldsMessage.isHidden = true

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
        defaults.set(name, forKey: "firstName")
        print(defaults.string(forKey: "firstName")!)
        
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
            
            print("Login successful.")
            strongSelf.loginLabel.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.eyeImage.isHidden = true
            strongSelf.firstNameField.isHidden = true
            strongSelf.continueButton.isHidden = true
            strongSelf.replaceVC(id: "tabBarVC")
            var defaultImage = UIImage(systemName: "person")
            var defaultImageData = defaultImage?.jpegData(compressionQuality: 1)
            var defaultImageDataBase64 = defaultImageData?.base64EncodedString()
            //self?.defaults.set(defaultImageDataBase64, forKey: "pfp")
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
                    strongSelf.allFieldsMessage.text = "Login failed. Please try again."
                    strongSelf.allFieldsMessage.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                        self!.allFieldsMessage.isHidden = true
                    }
                    return
                }
                
                print("Login successful.")
                strongSelf.replaceVC(id: "tabBarVC")
                var defaultImage = UIImage(systemName: "person")
                var defaultImageData = defaultImage?.jpegData(compressionQuality: 1)
                var defaultImageDataBase64 = defaultImageData?.base64EncodedString()
                //self?.defaults.set(defaultImageDataBase64, forKey: "pfp")
                
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
        }))
        present(alert, animated: true)
    }
}

