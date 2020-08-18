//
//  PostProblem.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
struct PostProblem: Codable {
    let post: Post
    let status: Bool
}

// MARK: - Post
struct Post: Codable {
    let address: String
    let approved: Bool
    let createdAt, details: String
    let imgPath: String?
    let likes: Int
    let name, phone, section: String
    let solved: Bool
    let updatedAt, userID: String
    let v: Int
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case address, approved
        case createdAt = "created_at"
        case details, imgPath, likes, name, phone, section, solved, updatedAt
        case userID = "userId"
        case v = "__v"
        case id = "_id"
    }
}
