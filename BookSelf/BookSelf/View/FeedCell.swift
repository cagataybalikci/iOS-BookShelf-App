//
//  FeedCell.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 20.07.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedCell: UITableViewCell {

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var cardVEView: UIVisualEffectView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userProfileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        postImage.layer.masksToBounds = true
        cardVEView.layer.masksToBounds = true
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

