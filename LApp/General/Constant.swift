//
//  Constant.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation


enum Constant {}

typealias DBKey = Constant.DBKey

extension Constant {
    struct DBKey {
        static let Users = "Users"
        static let ChatRooms = "ChatRooms"
        static let Chats = "Chats"
    }
}
