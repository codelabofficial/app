//
//  profileViewController.swift
//  codeLab
//
//  Created by Alfie on 01/01/2022.
//

import UIKit
import Firebase
import RSKImageCropper
import grpc
import MobileCoreServices
import Photos
import PhotosUI
import FirebaseStorage
import SDWebImage
import FirebaseStorageUI

class profileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate {
    
    var imagePicker:UIImagePickerController!
    var image: UIImage!
    var captureMediaActionSheet : UIAlertController!
    let defaults = UserDefaults.standard
    let storage = Storage.storage()
    let storageRef = Storage.storage().reference()
    
    /*
    // MARK: - ReplaceVC Function
    */
    
    func replaceVC(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }

    @IBOutlet weak var profilePhotoView: UIView!
    @IBOutlet weak var profilePhoto: circularImage!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var journeyMessage: UILabel!
    @IBOutlet weak var currentLanguage: UILabel!
    
    /*
    // MARK: - Image Cropping
    */
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        profilePhoto.image = croppedImage
        let snapshot: UIImage = croppedImage

        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: snapshot)
        }, completionHandler: { success, error in
            if success {
                print("Saved profile photo")
            }
            else if let error = error {
                print("Error saving profile photo")
            }
            else {
                print("Saving profile photo failed with no error")
            }
        })
        
        let uuid = (Auth.auth().currentUser?.uid)!
        
        let data = Data()
        
        let metadata = StorageMetadata()
        metadata.contentType = "jpg"

        // Create a reference to the file you want to upload
        let pythonRef = storageRef.child("\(String(describing: uuid))/ProfilePicture.jpg")

        // Upload the file to the path "images/Firebase.jpg"
        pythonRef.putData(data, metadata: metadata)

        // Upload file and metadata
        //pythonRef.putFile(from: localFile, metadata: metadata)
        pythonRef.putData(croppedImage.jpegData(compressionQuality: 1.0)!)
        let croppedImageData = croppedImage.jpegData(compressionQuality: 1)
        let croppedImageDataBase64 = croppedImageData?.base64EncodedString()
        defaults.set(croppedImageDataBase64, forKey: "pfp")
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Image Picker Controller
    */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imagePicker.dismiss(animated: false, completion: {})
        let imageCropVC = RSKImageCropViewController.init(image: self.image, cropMode: RSKImageCropMode.circle)
        imageCropVC.delegate = self;
        self.present(imageCropVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Setup action sheet
    */
    
    func setUpActionSheet() {
            captureMediaActionSheet = UIAlertController(title: "Choose Media", message: "", preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            }
            captureMediaActionSheet.addAction(cancelAction)
            let cameraAction: UIAlertAction = UIAlertAction(title: "Capture from Camera", style: .default) { action -> Void in
                self.imagePicker = UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            captureMediaActionSheet.addAction(cameraAction)
            let galleryAction: UIAlertAction = UIAlertAction(title: "Select from Gallery", style: .default) { action -> Void in
                self.imagePicker = UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            captureMediaActionSheet.addAction(galleryAction)
        }
    
    /*
    // MARK: - viewDidLoad() override
    */
    
    override func viewDidLoad() {
        
        let uuid = (Auth.auth().currentUser?.uid)!
        
        super.viewDidLoad()
        if defaults.string(forKey: "language") != nil {
            currentLanguage.text = "\(String(describing: defaults.string(forKey: "language")!))"
            if defaults.string(forKey: "language") == "Cpp" {
                currentLanguage.text = "C++"
            }
        }
//        var pfpImageData = Data(base64Encoded: (defaults.string(forKey: "pfp")!))
//        if var pfpImageData = pfpImageData {
//            profilePhoto.image = UIImage(data: pfpImageData, scale: 1)
//        } else {
//            profilePhoto.image = UIImage(systemName: "person")
//        }
        
        if defaults.string(forKey: "pfp") == "" || defaults.string(forKey: "pfp") == nil {
            // Create a reference to the file you want to download
            let pfpRef = storageRef.child("\(String(describing: uuid))/ProfilePicture.jpg")

            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            pfpRef.getData(maxSize: 3 * 3072 * 3072) { data, error in
              if let error = error {
                print("Download error")
              } else {
                  // Data for "images/island.jpg" is returned
                  let downloadedImage = UIImage(data: data!)
                  if downloadedImage == nil {
                      //self.profilePhoto.image = UIImage(systemName: "person")
                      print("downloadedImage is nil")
                  }
                  self.profilePhoto.image = downloadedImage
                  let imageData = downloadedImage?.jpegData(compressionQuality: 1.0)
                  var pfpImageData = Data(base64Encoded: imageData!)
                  self.defaults.set(pfpImageData, forKey: "pfp")
              }
            }
        } else if defaults.string(forKey: "pfp") != nil {
            var pfpImageData = Data(base64Encoded: (defaults.string(forKey: "pfp")!))
            self.profilePhoto.image = UIImage(data: pfpImageData!, scale: 1)
        }
        
        
        
        setUpActionSheet()
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.height/2
        profilePhoto.layer.masksToBounds = true
        journeyMessage.text = "\(defaults.string(forKey: "firstName")!)'s programming journey"
    }
    
    /*
    // MARK: - viewDidAppear() override
    */

    // Make sure language label changes if language
    // Selection changes in the same session
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }

    /*
    // MARK: - Change profile photo
    */
    
    @IBAction func changeProfilePhoto(_ sender: AnyObject) {
        present(captureMediaActionSheet, animated: true, completion: nil)
    }
 
    /*
    // MARK: - Logging out
    */
     
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            try Firebase.Auth.auth().signOut()
            logOutButton.isHidden = true
            super.viewDidLoad()
            replaceVC(id: "setupVC")
            defaults.set("Not assigned!", forKey: "language")
            defaults.set("", forKey: "pfp")
        } catch {
            print("An error occured while signing out")
            super.viewDidLoad()
        }
    }
}

extension UIView {
    func circular(
    borderWidth: CGFloat = 2.0,
    borderColour: CGColor = UIColor.lightGray.cgColor) {
        self.layer.cornerRadius = (self.frame.size.width / 2.0)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        self.layer.borderColor = borderColour
        self.layer.borderWidth = borderWidth
    }
}
