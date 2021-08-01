//
//  CreateVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 6.07.2021.
//

import UIKit
import Firebase

class CreateVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextView.delegate = self
        navItemsConfig()
        gestureRecognizerSetup()
    }
    
    //MARK: GESTURE RECOGNIZERS
    func gestureRecognizerSetup(){
        //For Keyboard
        let viewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewGestureRecognizer)
        
        // For ImagePicker
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        
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
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: NAVITEMS
    func navItemsConfig(){
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "CancelBtn"), style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelBtnPressed))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "DoneBtn"), style: UIBarButtonItem.Style.done, target: self, action: #selector(shareBtnPressed(_:)))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
    }
    
    
    //MARK: FIREBASE UPLOAD TO DB
    @IBAction @objc func shareBtnPressed(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { StorageMetadata, Error in
                if Error != nil{
                    self.showErrorMessage(title: "Error", messageBody: Error?.localizedDescription ?? "Error")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageURL = url?.absoluteString
                            
                            if let imageURL = imageURL{
                                let fireStoreDB = Firestore.firestore()
                                if self.captionTextView.text == "Enter your comment..." {
                                    self.captionTextView.text = ""
                                }
                                
                                let firestorePost = ["imageUrl":imageURL,"caption":self.captionTextView.text!,"email":Auth.auth().currentUser!.email  ,"date":FieldValue.serverTimestamp()] as [String:Any]
                                fireStoreDB.collection("Post").addDocument(data: firestorePost) { (error) in
                                    if error != nil{
                                        self.showErrorMessage(title: "Error", messageBody: error?.localizedDescription ?? "Error occured while creating post. Please try again.")
                                    }else{
                                        self.captionTextView.text = "Enter your comment..."
                                        self.imageView.image = #imageLiteral(resourceName: "imagePlaceholder")
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @objc func cancelBtnPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: ERROR MESSAGE GENERATOR
        
    func showErrorMessage(title: String, messageBody: String){
        let alert = UIAlertController(title: title, message: messageBody, preferredStyle: .alert)
            
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

//MARK: TEXTVIEW EXTENSIONS ~ PLACEHOLDER ETC.
extension CreateVC : UITextViewDelegate {

    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your comment..." {
            captionTextView.text = ""
            captionTextView.textColor = UIColor.init(named: "TextUIColor")

        }
        textView.becomeFirstResponder()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {
            captionTextView.text = "Enter your comment..."
            captionTextView.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        }
        textView.resignFirstResponder()
    }
    
    
}
