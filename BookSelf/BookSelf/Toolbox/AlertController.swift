//
//  AlertController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 28.07.2021.
//

import Foundation
import UIKit


struct AlertController {
    
    func showErrorMessage(title: String,message:String,view : UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okBtn)
        view.present(alert, animated: true, completion: nil)
    }
}


