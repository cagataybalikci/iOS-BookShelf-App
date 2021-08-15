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
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 20
        cardView.layer.cornerRadius = 20
        postImage.layer.masksToBounds = true
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 10
        
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        
        containerView.layer.shouldRasterize = true

        containerView.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

