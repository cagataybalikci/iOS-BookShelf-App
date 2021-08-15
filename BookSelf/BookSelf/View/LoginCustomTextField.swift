//
//  LoginCustomTextField.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 2.07.2021.
//

import UIKit


class LoginCustomTextField: UITextField {

    @IBInspectable var placeHolderColor: UIColor? {
           get {
               return self.placeHolderColor
           }
           set {
               self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
           }
       }

    //MARK: INIT & SETUP
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
