//
//  quarantine.swift
//  codeLab
//
//  Created by Alfie on 03/01/2022.
//

import Foundation
import Firebase
/*

func showCreateAccount(email: String, password: String) {
    let alert = UIAlertController(title: "No account found", message: "Would you like to create a account?", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Account creation failed")
                strongSelf.allFieldsMessage.text = "Login failed. Please try again"
                strongSelf.allFieldsMessage.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                    strongSelf.allFieldsMessage.isHidden = true
                return
                
            }
            
            Swift.print("Login successful. Welcome, \(strongSelf.accountFirstName).")
            strongSelf.loginLabel.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.eyeImage.isHidden = true
            strongSelf.firstNameField.isHidden = true
            strongSelf.continueButton.isHidden = true
            strongSelf.replaceVC(id: "tabBarVC")
        }
    })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
    }))
    
    present(self.alert, animated: true)
        
    })
                                  
                                  
})

*/

//        let image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerController.SourceType.photoLibrary
//        image.allowsEditing = false
//        self.present(image, animated: true)
        
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
//        self.present(imagePicker, animated: true, completion: nil)
