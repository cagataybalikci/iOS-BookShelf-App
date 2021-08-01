//
//  SignUpViewController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 6.07.2021.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: LoginCustomTextField!
    @IBOutlet weak var passwordTextField: LoginCustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss Keyboard
        createGestureRecognizer()
        
    }
    
    //MARK: Dismiss Keyboard
    
    func createGestureRecognizer(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    //MARK: Error Messages
    func showErrorMessage(title: String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }

    
    //MARK: Firebase ~ Create User
    @IBAction func signUpBtn(_ sender: Any) {
        if (emailTextField.text != "" && passwordTextField.text != "") {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { AuthDataResult, error in
                if (error != nil){
                    self.showErrorMessage(title: "Oops...", message: error?.localizedDescription ?? "Something went wrong. Please try again.")
                }else{
                    self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                }
            }
        }
    }
}
