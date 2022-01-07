//
//  fakeHomeViewController.swift
//  codeLab
//
//  Created by Alfie on 03/01/2022.
//

import UIKit
import Firebase

class fakeHomeViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var welcomeMessage: UILabel!
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //welcomeMessage.text = "Welcome back, \(defaults.string(forKey: "firstName")!)"

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
            if Auth.auth().currentUser != nil {
                print("Logged in already")
                replaceVC(id: "tabBarVC")
            } else { replaceVC(id: "newSetupVC") }
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
