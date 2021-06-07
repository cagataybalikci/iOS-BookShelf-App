//
//  AddBookViewController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 7.06.2021.
//

import UIKit

class AddBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var pageNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: ImagePicker Section
        bookImage.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickBookCover))
        
        bookImage.addGestureRecognizer(imageGestureRecognizer)
        
        
    }
    
    //MARK: Pick Image From Library
    @objc func pickBookCover(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        bookImage.image = info[.editedImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Save to Core Data
    
    @IBAction func saveDataBtnPressed(_ sender: Any) {
    }
    
    
}
