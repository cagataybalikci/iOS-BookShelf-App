//
//  ProfileVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 6.07.2021.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    @IBOutlet weak var profileName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItemsConfig()
        profileName.text = Auth.auth().currentUser?.email?.components(separatedBy: "@")[0].capitalized
        
    }
    
    //MARK: Navigation Items Config
    func navItemsConfig(){
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.sizeToFit()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "signout"), style: UIBarButtonItem.Style.done, target: self, action: #selector(signOut))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
    }
    
    
    @objc func signOut(){
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toExit", sender: nil)
        } catch {
            let alert = UIAlertController(title: "Oops.", message: "Something went wrong while sign out. Please try again.", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okBtn)
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    

}
