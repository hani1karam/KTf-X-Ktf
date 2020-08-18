//
//  ShowProblem.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/15/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
struct ShowProblem: Codable {
    let posts: [ShowProblemPost]
    let status: Bool?
}

// MARK: - Post
struct ShowProblemPost: Codable {
    let likes: Int?
    let id, name, address, phone: String
    let details, section, userID, createdAt,imgPath: String?
    let updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case likes
        case id = "_id"
        case name, address, phone, details, section,imgPath
        case userID = "userId"
        case createdAt = "created_at"
        case updatedAt
        case v = "__v"
    }
}
 
