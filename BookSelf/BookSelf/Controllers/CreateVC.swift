//
//  CreateVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 6.07.2021.
//

import UIKit

class CreateVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navItemsConfig()
    }
    

    func navItemsConfig(){
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "CancelBtn"), style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelBtnPressed))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "DoneBtn"), style: UIBarButtonItem.Style.done, target: self, action: #selector(doneBtnPressed))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
    }
    
    @objc func doneBtnPressed(){
        
    }
    
    @objc func cancelBtnPressed(){
        
    }

}
