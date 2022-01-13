//
//  ViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase
import FirebaseStorage

class ViewController: UIViewController {
    
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            print("Logged in already")
        } else { replaceVC(id: "setupVC") }
    }


}

