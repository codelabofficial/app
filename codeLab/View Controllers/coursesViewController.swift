//
//  coursesViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit

class coursesViewController: UIViewController {
    
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
        return selected
    }
    
    /*
    // MARK: - IBOutlet Setup
    */

    @IBOutlet weak var coursesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coursesTable.delegate = self
        coursesTable.dataSource = self

        // Do any additional setup after loading the view.
    }

}

/*
// MARK: - TableView Delegate
*/

extension coursesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesOffered.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courses", for: indexPath)
        cell.textLabel?.text = coursesOffered[indexPath.row]
        return cell
    }
}

/*
// MARK: - TableView DataSource
*/

extension coursesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellText = coursesTable.cellForRow(at: indexPath)?.textLabel?.text
        print("\(cellText!) tapped")
        let selectedLanguage: languages = selectLanguage(clicked: cellText!)
        print(selectedLanguage)
        var selectedLanguagePrint = ""
        if selectedLanguage == languages.Cpp {
            selectedLanguagePrint = "C++"
        } else {
            selectedLanguagePrint = "\(selectedLanguage)"
        }
        let confirmationMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to select \(selectedLanguagePrint)?", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
            print("Yes tapped")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel tapped")
        }
        
        confirmationMessage.addAction(ok)
        confirmationMessage.addAction(cancel)
        
        self.present(confirmationMessage, animated: true, completion: nil)
    }
}
