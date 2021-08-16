//
//  ProfileVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 6.07.2021.
//

import UIKit
import Firebase
import SDWebImage

class ProfileVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var profileCard: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileBioLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var userPosts = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItemsConfig()
        getUserInfo()
        layoutConfig()
        collectionView.delegate = self
        collectionView.dataSource = self
        getDatas()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutConfig()
    }

    //MARK: USER POSTS
    
    func getDatas(){
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Post").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error while getting data from server!" )
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userPosts.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        if let imageURL = document.get("imageUrl") as? String{
                            if let caption = document.get("caption") as? String{
                                let post = UserPost(caption: caption, imageUrl: imageURL)
                                self.userPosts.append(post)
                                self.postCountLabel.text = "\(self.userPosts.count)"
                            }
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //MARK: GET USER INFO
    
    func getUserInfo(){
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Users").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error while getting data from server!" )
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    for document in snapshot!.documents{
                        if let profileImg = document.get("profileImageURL") as? String{
                            if let bio = document.get("bio") as? String{
                                if let username = document.get("username") as? String{
                                    self.profileImage.sd_setImage(with: URL(string: profileImg))
                                    self.profileName.text = username
                                    self.profileBioLabel.text = bio
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }

    //MARK: UI Element Corner radius on start
    func layoutConfig() {
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        profileImage.layer.borderWidth = 5
        profileImage.layer.borderColor = UIColor(named: "AppUIColor")?.cgColor
        profileCard.layer.cornerRadius = 20
        
    }
    //MARK: Navigation Items Config
    func navItemsConfig(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.font = UIFont(name: "Avenir Next Bold", size: 20)
        titleLabel.sizeToFit()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "signout"), style: UIBarButtonItem.Style.done, target: self, action: #selector(showAlertWithDistructiveButton))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor(named: "AccentColor")
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toUpdate", sender: nil)
    }
    

    @objc func showAlertWithDistructiveButton() {
            let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style:.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Sign out",
                                          style: .destructive,
                                          handler: {(_: UIAlertAction!) in
                                            do {
                                                try Auth.auth().signOut()
                                                self.performSegue(withIdentifier: "toExit", sender: nil)
                                            } catch {
                                                let alert = UIAlertController(title: "Oops.", message: "Something went wrong while sign out. Please try again.", preferredStyle: .alert)
                                                let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
                                                alert.addAction(okBtn)
                                                self.present(alert, animated: true, completion: nil)
                                            }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    

}

//MARK: Collection View Extensions
extension ProfileVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! postCell
        cell.userPostImage.sd_setImage(with: URL(string: self.userPosts[indexPath.row].imageUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cel \(indexPath.row) Selected")
    }
}

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        let heigth = collectionView.bounds.height / 3
        
        return CGSize(width: width, height: heigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
