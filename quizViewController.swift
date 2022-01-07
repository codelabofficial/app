//
//  quizViewController.swift
//  codeLab
//
//  Created by Alfie on 07/01/2022.
//

import UIKit

class quizViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    enum languages {
        case C
        case Cpp
        case Python
        case Swift
        case Java
        case HTML
        case CSS
        case JavaScript
        case undefined
    }
    
    enum reasonForInstall {
        case wantsToCode
        case wantsToRefresh
        case wantsToKeepLearning
        case wantsToBuildWebsites
        case wantsToBuildApps
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    let question1: [String:String] = ["questionLabel": "Which of these languages do you have the most experience in?", "button1": "C", "button2": "C++", "button3": "Python", "button4": "Swift", "button5": "Java", "button6": "HTML", "button7": "CSS", "button8": "JavaScript", "button9": "None"]
    let question2: [String:String] = ["questionLabel": "Why did you install codeLab?", "button1": "", "button2": "", "button3": "I want to learn to code", "button4": "I've coded before, and want to refresh my skills", "button5": "I am an experienced programmer and want to keep learning", "button6": "I want to build websites", "button7": "I want to build apps", "button8": "", "button9": ""]
    
    func firstQuestion() {
        questionLabel.text = question1["questionLabel"]
        button1.titleLabel?.text = question1["button1"]
        button2.titleLabel?.text = question1["button2"]
        button3.titleLabel?.text = question1["button3"]
        button4.titleLabel?.text = question1["button4"]
        button5.titleLabel?.text = question1["button5"]
        button6.titleLabel?.text = question1["button6"]
        button7.titleLabel?.text = question1["button7"]
        button8.titleLabel?.text = question1["button8"]
        button9.titleLabel?.text = question1["button9"]
    }
    
    func secondQuestion() {
        let currentQuestion: Int = 2
        defaults.set(currentQuestion, forKey: "currentQuestion")
        questionLabel.text = question2["questionLabel"]
        button1.isHidden = true
        button2.isHidden = true
        button3.titleLabel?.text = question2["button3"]
        button4.titleLabel?.text = question2["button4"]
        button5.titleLabel?.text = question2["button5"]
        button6.titleLabel?.text = question2["button6"]
        button7.titleLabel?.text = question2["button7"]
        button8.isHidden = true
        button9.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let questions = [question1, question2]
        var previousExperience: String = ""
        var currentQuestion: Int = 1
        
        firstQuestion()
        
        defaults.set(currentQuestion, forKey: "currentQuestion")
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.C
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
            button1.isHidden = true
        }
    }
    @IBAction func button2Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Cpp
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
            button2.isHidden = true
        }
    }
    @IBAction func button3Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Python
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
            button3.titleLabel?.text = question2["button3"]
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            let reasonForInstallVar = reasonForInstall.wantsToCode
            print(reasonForInstallVar)
            let reasonForInstallVarPrint: String = "\(reasonForInstallVar)"
            defaults.set(reasonForInstallVarPrint, forKey: "reasonForInstall")
            print(defaults.string(forKey: "reasonForInstall")!)
        }
    }
    @IBAction func button4Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Swift
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            
        }
    }
    @IBAction func button5Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Java
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
        }
    }
    @IBAction func button6Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.HTML
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            
        }
    }
    @IBAction func button7Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.CSS
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
        }
    }
    @IBAction func button8Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.JavaScript
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
            button8.isHidden = true
        }
    }
    @IBAction func button9Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.undefined
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLangauge")
            secondQuestion()
            button9.isHidden = true
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
