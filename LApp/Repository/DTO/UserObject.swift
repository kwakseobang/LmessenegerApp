//
//  UserObject.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation

struct UserObject: Codable {
    var id:String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}
