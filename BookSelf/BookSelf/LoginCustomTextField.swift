//
//  LoginCustomTextField.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 2.07.2021.
//

import UIKit


class LoginCustomTextField: UITextField {
    
    
    
    func setup() {
        let border = CALayer()
        let width = CGFloat(3.0)
        border.borderColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    @IBInspectable var leftImage : UIImage? {
            didSet {
                setIcon()
            }
    }
    
    
    func setIcon(){
        if let image = leftImage{
            let iconView = UIImageView(frame:CGRect(x: 6, y: -3, width: 20, height: 20))
            iconView.image = image
            let iconContainerView: UIView = UIView(frame:CGRect(x: 20, y: 0, width: 30, height: 20))
            iconContainerView.addSubview(iconView)
            self.leftView = iconContainerView
            self.leftViewMode = .always
            self.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
        }
    }
    
    
    
    //MARK: INIT & SETUP
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setIcon()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setIcon()
    }
    
}
