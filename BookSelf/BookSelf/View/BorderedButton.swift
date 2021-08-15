//
//  BorderedButton.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 15.08.2021.
//

import UIKit

class BorderedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        self.layer.cornerRadius = 5
    }
    
   
}
