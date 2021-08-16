//
//  UpdateProfileVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 9.08.2021.
//

import UIKit
import Firebase
import SDWebImage

class UpdateProfileVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var profileImageAddBtn: UIButton!
    @IBOutlet weak var BannerAddBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImageView.addGestureRecognizer(imageGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        updateBtn.isEnabled = false
        setupForGestureRecognizers()
        
        //TODO: Extract Own Method
        profileImageAddBtn.layer.cornerRadius = profileImageAddBtn.bounds.width / 2
        profileImageAddBtn.layer.borderColor = UIColor(named: "CreatePostUIColor")?.cgColor
        profileImageAddBtn.layer.borderWidth = 2
        
        profileImageView.layer.borderColor = UIColor(named: "AppUIColor")?.cgColor
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        
        BannerAddBtn.layer.cornerRadius = BannerAddBtn.bounds.width / 2
        
    }
    
    func setupForGestureRecognizers(){
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImageView.addGestureRecognizer(imageGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        let dismissGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissGestureRecognizer)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    //MARK: IMAGEPICKER
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImageView.image = info[.originalImage] as? UIImage
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        updateBtn.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: POST USER INFO TO DB
    func updateProfile(){
        if usernameTextField.text != "" && bioTextField.text != "" {
            if let image = profileImageView.image{
                let userImagesFolder = Storage.storage().reference().child("User Profile Images")
                if let data = image.jpegData(compressionQuality: 0.5){
                    let uuid = UUID().uuidString
                    let imageReference = userImagesFolder.child("\(uuid).jpg")
                    imageReference.putData(data, metadata: nil) { StorageMetadata, Error in
                        if Error != nil{
                            print(Error?.localizedDescription ?? "error while uploadin pp image")
                        }else{
                            imageReference.downloadURL { url, error in
                                if error == nil{
                                    let imageURL = url?.absoluteString
                                    
                                    if let imageURL = imageURL{
                                        let fireStoreDB = Firestore.firestore()
                                        let userInfo = ["profileImageURL":imageURL,"bio":self.bioTextField.text!,"username":self.usernameTextField.text!,"email":Auth.auth().currentUser?.email!] as [String:Any]
                                        fireStoreDB.collection("Users").addDocument(data: userInfo) { Error in
                                            if Error != nil{
                                                print(Error?.localizedDescription ?? "DB upload problem")
                                            }else{
                                                self.performSegue(withIdentifier: "toMain", sender: nil)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        updateProfile()
    }
        
}
