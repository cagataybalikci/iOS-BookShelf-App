//
//  User.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 9.08.2021.
//

import Foundation

struct User {
    var userName : String
    var userPhotoImage : String
    
    init(username: String,userPhotoImage:String) {
        self.userName = username
        self.userPhotoImage = userPhotoImage
    }
}
