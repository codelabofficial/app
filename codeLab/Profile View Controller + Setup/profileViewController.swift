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

class profileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate {
    
    var imagePicker:UIImagePickerController!
    var image: UIImage!
    var captureMediaActionSheet : UIAlertController!
    let defaults = UserDefaults.standard
    
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
        var croppedImageData = croppedImage.jpegData(compressionQuality: 1)
        var croppedImageDataBase64 = croppedImageData?.base64EncodedString()
        defaults.set(croppedImageDataBase64, forKey: "pfp")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imagePicker.dismiss(animated: false, completion: {})
        let imageCropVC = RSKImageCropViewController.init(image: self.image, cropMode: RSKImageCropMode.circle)
        imageCropVC.delegate = self;
        self.present(imageCropVC, animated: true, completion: nil)
    }
    
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
        super.viewDidLoad()
        if defaults.string(forKey: "language") != nil {
            currentLanguage.text = "\(String(describing: defaults.string(forKey: "language")!))"
            if defaults.string(forKey: "language") == "Cpp" {
                currentLanguage.text = "C++"
            }
        }
        var pfpImageData = Data(base64Encoded: (defaults.string(forKey: "pfp")!))
        if var pfpImageData = pfpImageData {
            profilePhoto.image = UIImage(data: pfpImageData, scale: 1)
        } else {
            profilePhoto.image = UIImage(systemName: "person")
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
