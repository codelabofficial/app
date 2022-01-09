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
    @IBOutlet weak var resultsSubheading: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    
    let question1: [String:String] = ["questionLabel": "Which of these languages do you have the most experience in?", "button1": "C", "button2": "C++", "button3": "Python", "button4": "Swift", "button5": "Java", "button6": "HTML", "button7": "CSS", "button8": "JavaScript", "button9": "None"]
    let question2: [String:String] = ["questionLabel": "Why did you install codeLab?", "button1": "", "button2": "", "button3": "I want to learn to code", "button4": "I've coded before, and want to refresh my skills", "button5": "I am an experienced programmer and want to keep learning", "button6": "I want to build websites", "button7": "I want to build apps", "button8": "", "button9": ""]
    
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
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
    
    func results() {
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        button5.isHidden = true
        button6.isHidden = true
        button7.isHidden = true
        button8.isHidden = true
        button9.isHidden = true
        returnButton.isHidden = false
        resultsSubheading.isHidden = false
        let currentQuestion: Int = 3
        defaults.set(currentQuestion, forKey: "currentQuestion")
        if defaults.string(forKey: "reasonForInstall") == "\(reasonForInstall.wantsToBuildWebsites)" {
            questionLabel.text = "We think you should start your web development journey by taking the HTML course."
            resultsSubheading.text = "HTML is the base programming language for every website on the internet. HTML allows you to setup the skeleton of the website (text, images etc.). Once you've finished, you have CSS (colours, shapes etc.) and then JavaScript (scripting, buttons etc.)."
        }
        if defaults.string(forKey: "reasonForInstall") == "\(reasonForInstall.wantsToBuildApps)" {
            questionLabel.text = "We think you should start your app development journey by taking the Swift course."
            resultsSubheading.text = "Although Swift is only for Apple devices, the language and it's development software are an excellent array of tools to help you learn. This app is written entirely in Swift, so we know what we are talking about!"
        }
        if defaults.string(forKey: "reasonForInstall") == "\(reasonForInstall.wantsToCode)" {
            questionLabel.text = "We think you should start your programming journey by taking the Python course."
            resultsSubheading.text = "Python is renowned as a beginner's language, and is known for its easy syntax and simple code."
        }
        if defaults.string(forKey: "reasonForInstall") == "\(reasonForInstall.wantsToKeepLearning)" {
            if defaults.string(forKey: "experiencedLanguage") == "\(languages.Cpp)" {
                questionLabel.text = "We think you should keep at C++ and continue to learn."
            } else {
                questionLabel.text = "We think you should keep at \(String(describing: defaults.string(forKey: "experiencedLanguage")!)) and continue to learn."
            }
            if defaults.string(forKey: "experiencedLanguage") == "\(languages.C)" {
                resultsSubheading.text = "Alternatively, we think you would benefit from our C++ course, as it is similar to C. We would also recommend Python, as it is becoming much more popular and is easy to learn."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Cpp)" {
                resultsSubheading.text = "Seeing as you are familiar with C++, it probably isn't worth taking the C course. We would recommend the Python or Java course as they are overtaking the classic C languages."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Python)" {
                resultsSubheading.text = "Considering you already know how to use Python, we would recommend that you could also take the Java course, as we believe it is the next step after Python."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Swift)" {
                resultsSubheading.text = "Because Swift is built for Apple devices, you could also take the Python or Java course to expand into more general-use languages."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Java)" {
                resultsSubheading.text = "As you are familiar wih Java, you could also consider the Python course or the C/C++ course if you are interested in building complex computer software."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.HTML)" {
                resultsSubheading.text = "If you don't fancy that, you could expand your CSS or JavaScript skills for front-end web development. Alternatively, Python and Java are very good if you want to write more backend code."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.CSS)" {
                resultsSubheading.text = "If you don't fancy that, you could expand your HTML or JavaScript skills for front-end web development. Alternatively, Python and Java are very good if you want to write more backend code."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.JavaScript)" {
                resultsSubheading.text = "If you don't fancy that, you could expand your HTML or CSS skills for front-end web development. Alternatively, Python and Java are very good if you want to write more backend code."
            }
        }
        if defaults.string(forKey: "reasonForInstall") == "\(reasonForInstall.wantsToRefresh)" {
            if defaults.string(forKey: "experiencedLanguage") == "\(languages.Cpp)" {
                questionLabel.text = "We think you should refresh your memory by taking the C++ course."
            } else {
                questionLabel.text = "We think you should refresh your memory by taking the \(String(describing: defaults.string(forKey: "experiencedLanguage")!)) course."
            }
            if defaults.string(forKey: "experiencedLanguage") == "\(languages.C)" {
                resultsSubheading.text = "Alternatively, we think you would benefit from our C++ course, as it is similar to C. We would also recommend Python, as it is becoming much more popular and is easy to learn."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Cpp)" {
                resultsSubheading.text = "Seeing as you are familiar with C++, it probably isn't worth taking the C course. We would recommend the Python or Java course as they are overtaking the classic C languages."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Python)" {
                resultsSubheading.text = "Considering you already know how to use Python, we would recommend that you could also take the Java course,as we believe it is the next step after Python."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Swift)" {
                resultsSubheading.text = "Because Swift is built for Apple devices, you could also take the Python or Java course to expand into more general-use languages."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.Java)" {
                resultsSubheading.text = "As you are familiar wih Java, you could also consider the Python course or the C/C++ course if you are interested in building complex computer software."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.HTML)" {
                resultsSubheading.text = "If you don't fancy that, you could expand your CSS or JavaScript skills for front-end web development. Alternatively, Python and Java are very good if you want to write more backend code."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.CSS)" {
                resultsSubheading.text = "If you don't fancy that, you could expand your HTML or JavaScript skills for front-end web development. Alternatively, Python and Java are very good if you want to write more backend code."
            } else if defaults.string(forKey: "experiencedLanguage") == "\(languages.JavaScript)" {
                resultsSubheading.text = "If you don't fancy that, you could expand your HTML or CSS skills for front-end web development. Alternatively, Python and Java are very good if you want to write more backend code."
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let questions = [question1, question2]
        //var previousExperience: String = ""
        let currentQuestion: Int = 1
        
        firstQuestion()
        
        defaults.set(currentQuestion, forKey: "currentQuestion")
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.C
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
            button1.isHidden = true
        }
    }
    @IBAction func button2Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Cpp
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
            button2.isHidden = true
        }
    }
    @IBAction func button3Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Python
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
            button3.titleLabel?.text = question2["button3"]
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            let reasonForInstallVar = reasonForInstall.wantsToCode
            print(reasonForInstallVar)
            let reasonForInstallVarPrint: String = "\(reasonForInstallVar)"
            defaults.set(reasonForInstallVarPrint, forKey: "reasonForInstall")
            print(defaults.string(forKey: "reasonForInstall")!)
            results()
        }
    }
    @IBAction func button4Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Swift
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            let reasonForInstallVar = reasonForInstall.wantsToRefresh
            print(reasonForInstallVar)
            let reasonForInstallVarPrint: String = "\(reasonForInstallVar)"
            defaults.set(reasonForInstallVarPrint, forKey: "reasonForInstall")
            print(defaults.string(forKey: "reasonForInstall")!)
            results()
        }
    }
    @IBAction func button5Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.Java
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            let reasonForInstallVar = reasonForInstall.wantsToKeepLearning
            print(reasonForInstallVar)
            let reasonForInstallVarPrint: String = "\(reasonForInstallVar)"
            defaults.set(reasonForInstallVarPrint, forKey: "reasonForInstall")
            print(defaults.string(forKey: "reasonForInstall")!)
            results()
        }
    }
    @IBAction func button6Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.HTML
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            let reasonForInstallVar = reasonForInstall.wantsToBuildWebsites
            print(reasonForInstallVar)
            let reasonForInstallVarPrint: String = "\(reasonForInstallVar)"
            defaults.set(reasonForInstallVarPrint, forKey: "reasonForInstall")
            print(defaults.string(forKey: "reasonForInstall")!)
            results()
        }
    }
    @IBAction func button7Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.CSS
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
        } else if defaults.integer(forKey: "currentQuestion") == 2 {
            let reasonForInstallVar = reasonForInstall.wantsToBuildApps
            print(reasonForInstallVar)
            let reasonForInstallVarPrint: String = "\(reasonForInstallVar)"
            defaults.set(reasonForInstallVarPrint, forKey: "reasonForInstall")
            print(defaults.string(forKey: "reasonForInstall")!)
            results()
        }
    }
    @IBAction func button8Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.JavaScript
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
            button8.isHidden = true
        }
    }
    @IBAction func button9Pressed(_ sender: Any) {
        if defaults.integer(forKey: "currentQuestion") == 1 {
            let experiencedLanguage = languages.undefined
            print(experiencedLanguage)
            let experiencedLanguagePrint: String = "\(experiencedLanguage)"
            defaults.set(experiencedLanguagePrint, forKey: "experiencedLanguage")
            secondQuestion()
            button9.isHidden = true
        }
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        replaceVC(id: "tabBarVC")
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
