//
//  RegisterModel.swift
//  KTf X Ktf
//
//  Created by Hany Karam on 8/14/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
 
// MARK: - RegisterModel
struct RegisterModel: Codable {
    let user: User?
    let msg: String?
}

// MARK: - User
struct User: Codable {
    let status, id, email, password: String?
    let phone, code: String?
    let codeExpiry, v: Int?

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case email, password, phone, code, codeExpiry
        case v = "__v"
    }
}
