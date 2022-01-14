//
//  homeViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase
import AudioToolbox
import SPConfetti

class homeViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

    @IBOutlet weak var checkupMessage: UILabel!
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var thumbsUpButton: UIButton!
    @IBOutlet weak var thumbsDownButton: UIButton!
    @IBOutlet weak var feedbackResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var language = ""
        
        if defaults.string(forKey: "language") != nil {
            language = defaults.string(forKey: "language")!
            if language == "Cpp" {
                checkupMessage.text = "Are you enjoying your C++ course?"
            } else {
                checkupMessage.text = "Are you enjoying your \(String(describing: language)) course?"
            }
        } else if defaults.string(forKey: "language") == nil {
            language = "Not assigned!"
            checkupMessage.text = "Please select a course"
        }
        
        languageImage.image = UIImage(named: language)
        
        welcomeMessage.text = "Welcome back, \(defaults.string(forKey: "firstName")!)"
         
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            print("Logged in already")
//            do {
//                try Auth.auth().signOut()
//            } catch {
//                print("Could not sign out")
//            }
            
        } else { replaceVC(id: "setupVC") }
        viewDidLoad()
    }

    @IBAction func thumbsUpButtonPressed(_ sender: Any) {
        feedbackResult.text = "That's great to hear!"
        feedbackResult.textColor = .green
        feedbackResult.isHidden = false
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        thumbsUpButton.tintColor = .green
        SPConfetti.startAnimating(.fullWidthToDown, particles: [.triangle, .arc, .circle, .polygon, .heart, .star], duration: 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            thumbsUpButton.tintColor = .systemBlue
            SPConfetti.stopAnimating()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            feedbackResult.isHidden = true
        }
    }
    
    @IBAction func thumbsDownButtonPressed(_ sender: Any) {
        feedbackResult.text = "That's not so good. You can always get in touch with feedback if you want to."
        feedbackResult.textColor = .red
        feedbackResult.isHidden = false
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        thumbsDownButton.tintColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            thumbsDownButton.tintColor = .systemBlue
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            feedbackResult.isHidden = true
        }
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
