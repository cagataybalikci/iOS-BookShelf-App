//
//  FeedVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 6.07.2021.
//

import UIKit

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navItemsConfig()
    }
    

    //MARK: Navigation Items Config
    func navItemsConfig(){
        let titleLabel = UILabel()
        titleLabel.text = "Bookshelf"
        titleLabel.sizeToFit()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Add Btn"), style: UIBarButtonItem.Style.done, target: self, action: #selector(addBtnPressed))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
    }
    
    @objc func addBtnPressed(){
        performSegue(withIdentifier: "toCreateVC", sender: nil)
    }

}
