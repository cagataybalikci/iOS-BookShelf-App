//
//  Post.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 20.07.2021.
//

import Foundation

struct Post{
    var email:String
    var caption:String
    var imageUrl:String
    
    init(email:String,caption:String,imageUrl:String) {
        self.email = email
        self.caption = caption
        self.imageUrl = imageUrl
        
    }
}
