//
//  SignInViewController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 2.07.2021.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var passwordTextField: LoginCustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        addForgotButton()
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
}
