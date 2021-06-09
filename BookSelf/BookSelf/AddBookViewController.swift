//
//  AddBookViewController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 7.06.2021.
//

import UIKit
import CoreData

class AddBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var pageNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageTapGestureRecognizer()
    }
    //MARK: ImageTapGestureRecognizer and ImagePicker Section
    func imageTapGestureRecognizer(){
        
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    //MARK: Dismiss Keyboard
    
    @objc func dismissKeyboard(){
        print("Keyboard Dismissed")
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Save to Core Data
    
    @IBAction func saveDataBtnPressed(_ sender: Any) {
        print("Button Tapped")
        saveData()
        
    }
    
    func saveData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let books = NSEntityDescription.insertNewObject(forEntityName: "Books", into: context)
        
        books.setValue(bookTitleTextField.text!, forKey: "bookName")
        
        if let pageNumber = Int(pageNumberTextField.text!){
            books.setValue(pageNumber, forKey: "pageNumber")
        }
        
        
       
        books.setValue(authorTextField.text!, forKey: "author")
        books.setValue(UUID(),forKey: "id")
        
        let data = bookImage.image!.jpegData(compressionQuality: 0.5)
        
        books.setValue(data, forKey: "image")
        
        
        
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Error!")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataEntered"), object: nil)
        navigationController?.popViewController(animated: true)
        
    }
}
