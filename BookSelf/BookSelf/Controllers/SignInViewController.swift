//
//  SignInViewController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 2.07.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: LoginCustomTextField!
    
    @IBOutlet weak var passwordTextField: LoginCustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        addForgotButton()
        // Dismiss Keyboard
        createGestureRecognizer()
    }
    

    //MARK: Forgot Password Button for PasswordTextField
    
    func addForgotButton(){
        let forgotBtn = UIButton(type: .custom)
        forgotBtn.frame = CGRect(x: passwordTextField.frame.size.width - 25, y: 0, width: 25, height: 19)
        forgotBtn.setTitle("FORGOT", for: UIControl.State.normal)
        forgotBtn.setTitleColor(#colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1), for: UIControl.State.normal)
        forgotBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        forgotBtn.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        passwordTextField.rightView = forgotBtn
        passwordTextField.rightViewMode = .always
    }
    
    @objc func forgetPassword(){
        print("Forgot Tapped")
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
    @IBAction func loginBtnPressed(_ sender: Any) {
        if(emailTextField.text != "" && passwordTextField.text != "" ){
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { AuthDataResult, error in
                if(error != nil){
                    self.showErrorMessage(title: "Something wrong...", message: error?.localizedDescription ?? "Check your email or password and try again to login.")
                }else{
                    self.performSegue(withIdentifier: "toTabVC", sender: nil)
                }
            }
        }
    }
}
