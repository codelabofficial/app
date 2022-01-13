//
//  lessonViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseAuth

class lessonViewController: UIViewController {
    
    let storage = Storage.storage()
    let storageRef = Storage.storage().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        
        let uuid = (Auth.auth().currentUser?.uid)!
        
        let data = Data()
        
        let metadata = StorageMetadata()
        metadata.contentType = "png"
        
        // File located on disk
        let localFile = URL.localURLForXCAsset(name: "Python.png")!

        // Create a reference to the file you want to upload
        let pythonRef = storageRef.child("\(String(describing: uuid))/Firebase.png")

        // Upload the file to the path "images/rivers.jpg"
        pythonRef.putData(data, metadata: metadata)

        // Upload file and metadata
        pythonRef.putFile(from: localFile, metadata: metadata)
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

extension URL {
    static func localURLForXCAsset(name: String) -> URL? {
        let fileManager = FileManager.default
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        if !fileManager.fileExists(atPath: path) {
            guard let image = UIImage(named: name), let data = image.pngData() else {return nil}
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
        }
        return url
    }
}
