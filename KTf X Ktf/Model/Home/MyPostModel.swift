//
//  MyPostModel.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
struct ShowPosts: Codable {
    let posts: [UserPost]
    let status: Bool
}

// MARK: - Post
struct UserPost: Codable {
    let likes: Int
    let solved, approved: Bool
    let id, name, address, phone: String
    let details, section, userID, createdAt: String
    let updatedAt: String
    let v: Int
    let imgPath:String?
    let likers: Likers?
    
    enum CodingKeys: String, CodingKey {
        case likes, solved, approved
        case id = "_id"
        case name, address, phone, details, section,imgPath
        case userID = "userId"
        case createdAt = "created_at"
        case updatedAt
        case v = "__v"
        case likers
    }
}

// MARK: - Likers
struct Likers: Codable {
    let the5Ed0149D901F950004D09D68: Int
    
    enum CodingKeys: String, CodingKey {
        case the5Ed0149D901F950004D09D68 = "5ed0149d901f950004d09d68"
    }
}

