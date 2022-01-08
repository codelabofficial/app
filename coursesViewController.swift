//
//  coursesViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit

class coursesViewController: UIViewController {
    
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    let defaults = UserDefaults.standard
    
    /*
    // MARK: - Course options
    */
    
    let coursesOffered = [
        "C",
        "C++",
        "Python",
        "Swift",
        "Java",
        "HTML",
        "CSS",
        "JavaScript"
    ]
    
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
    
    /*
    // MARK: - selectLanguage Function
    */
    
    func selectLanguage(clicked: String) -> languages {
        var selected = languages.C
        if clicked == "C" {
            selected = languages.C
        }
        if clicked == "C++" {
            selected = languages.Cpp
        }
        if clicked == "Python" {
            selected = languages.Python
        }
        if clicked == "Swift" {
            selected = languages.Swift
        }
        if clicked == "Java" {
            selected = languages.Java
        }
        if clicked == "HTML" {
            selected = languages.HTML
        }
        if clicked == "CSS" {
            selected = languages.CSS
        }
        if clicked == "JavaScript" {
            selected = languages.JavaScript
        }
        defaults.set("\(selected)", forKey: "language")
        //profileViewController.currentLanguage.text = "\((defaults.set("\(selected)", forKey: "language")!))"
        return selected
    }
    
    /*
    // MARK: - IBOutlet Setup
    */
    @IBOutlet weak var coursesTable: UITableView!
    
    @IBAction func quizButton(_ sender: Any) {
        print("Quiz")
        replaceVC(id: "quizVC")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursesTable.delegate = self
        coursesTable.dataSource = self
        
        coursesTable.separatorStyle = .none
        coursesTable.showsVerticalScrollIndicator = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = coursesTable.indexPathForSelectedRow {
            coursesTable.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }

}

/*
// MARK: - TableView Delegate
*/

extension coursesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesOffered.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courses") as! coursesTableViewCell
        let courseType = coursesOffered[indexPath.row]
        
        cell.courseLabel.text = courseType
        cell.courseImage.image = UIImage(named: courseType)
        
        if courseType == "C++" {
            cell.courseImage.image = UIImage(named: "Cpp")
        }
        
        cell.courseView.layer.cornerRadius = cell.courseView.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let courseInCell = coursesOffered[indexPath.row]
        //let cell = tableView.dequeueReusableCell(withIdentifier: "courses") as! coursesTableViewCell
        let selectedLanguage = String(describing: courseInCell)
        
        print("Selected \(selectedLanguage)")
        let confirmationMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to select \(courseInCell)?", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            print("Yes tapped")
            self.selectLanguage(clicked: selectedLanguage)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel tapped")
        }
        
        confirmationMessage.addAction(ok)
        confirmationMessage.addAction(cancel)
        
        self.present(confirmationMessage, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
