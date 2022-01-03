//
//  homeViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase

class homeViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

    @IBOutlet weak var welcomeMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeMessage.text = "Welcome back, \(defaults.string(forKey: "firstName")!)"
        
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
