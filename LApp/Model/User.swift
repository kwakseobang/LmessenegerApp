//
//  User.swift
//  LApp
//
//  Created by 곽서방 on 7/20/24.
//

import Foundation

struct User {
    var id:String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}

extension User {
    static var stub1: User {
        .init(id: "user1", name: "곽문수")
    }
    static var stub2: User {
        .init(id: "user2", name: "곽태풍")
    }
    static var stub3: User {
        .init(id: "user3", name: "송하영")
    }
}
