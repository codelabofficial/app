//
//  homeViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase
import SPConfetti
import AudioToolbox

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
        } else { replaceVC(id: "setupVC") }
        viewDidLoad()
    }

    @IBAction func thumbsUpButtonPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        thumbsUpButton.tintColor = .green
        SPConfetti.startAnimating(.fullWidthToDown, particles: [.triangle, .arc, .circle, .polygon, .heart, .star], duration: 1.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            thumbsUpButton.tintColor = .systemBlue
            SPConfetti.stopAnimating()
        }
    }
    
    @IBAction func thumbsDownButtonPressed(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        thumbsDownButton.tintColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            thumbsDownButton.tintColor = .systemBlue
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
