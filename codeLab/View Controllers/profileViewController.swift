//
//  profileViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase

class profileViewController: UIViewController {

    @IBOutlet weak var notLoggedInMessage: UILabel!
    @IBOutlet weak var continueToSetupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notLoggedInMessage.isHidden = true
        continueToSetupButton.isHidden = true
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            
            notLoggedInMessage.isHidden = false
            continueToSetupButton.isHidden = false
            
            print("No user logged in")
        
//            let noLoginMessage = UIAlertController(title: "Please login", message: "You are not logged in. Please login or create an account to continue using codeLab", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
//                self.present(newSetupViewController(), animated: true, completion: nil)
//            }
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//                print("Cancel tapped")
//            }
//
//            noLoginMessage.addAction(ok)
//            noLoginMessage.addAction(cancel)
//
//            self.present(noLoginMessage, animated: true, completion: nil)
             
        }

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
