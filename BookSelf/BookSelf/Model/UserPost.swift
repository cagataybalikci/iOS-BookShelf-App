//
//  UserPost.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 28.07.2021.
//

import Foundation


struct UserPost {
    var caption : String
    var imageUrl : String
    
    init(caption:String,imageUrl:String) {
        self.caption = caption
        self.imageUrl = imageUrl
        
    }
}
