//
//  FeedVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 6.07.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray = [Post]()
    var userInfo = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navItemsConfig()
        tableView.delegate = self
        tableView.dataSource = self
        getDatas()
        
    
        
    }
    
    
    //MARK: FIREBASE GET DATAS
    func getDatas(){
        let firestoreDB = Firestore.firestore()
        
        firestoreDB.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error while getting data from server!" )
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.postArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        if let imageURL = document.get("imageUrl") as? String{
                            if let caption = document.get("caption") as? String{
                                if let email = document.get("email") as? String{
                                    let post = Post(email: email, caption: caption, imageUrl: imageURL)
                                    self.postArray.append(post)
                                    
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: FIREBASE USER INFO
    func getUserInfo(userEmail:String,cell: FeedCell){
        let firestoreDB = Firestore.firestore()
        
        firestoreDB.collection("Users").whereField("email", isEqualTo: userEmail).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error while getting data from server!" )
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userInfo.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        if let profileImg = document.get("profileImageURL") as? String{
                                if let username = document.get("username") as? String{
                                    cell.userNameLabel.text = username
                                    cell.userProfileImage.sd_setImage(with: URL(string: profileImg))
                                    cell.userProfileImage.layer.cornerRadius = 20

                                }
                        }
                    }
                }
                
            }
        }
    }
    
    

    //MARK: Navigation Items Config
    func navItemsConfig(){
        let titleLabel = UILabel()
        titleLabel.text = "Bookshelf"
        titleLabel.font = UIFont(name: "OpenSans-Bold", size: 20)
        titleLabel.sizeToFit()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Add Btn"), style: UIBarButtonItem.Style.done, target: self, action: #selector(addBtnPressed))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
    }
    
    @objc func addBtnPressed(){
        performSegue(withIdentifier: "toCreateVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        self.getUserInfo(userEmail: postArray[indexPath.row].email,cell: cell)
        cell.captionLabel.text =  postArray[indexPath.row].caption
        cell.postImage.sd_setImage(with: URL(string: postArray[indexPath.row].imageUrl))
        return cell
    }

}
