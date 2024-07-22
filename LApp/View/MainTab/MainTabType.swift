//
//  MainTabType.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation

enum MainTabType: String, CaseIterable {
    case home
    case chat
    case phone
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .chat:
            return "채팅"
        case .phone:
            return "통화"
        }
    }
    //image 클릭 여부
    func imageName(selected: Bool) -> String{
        selected ? "\(rawValue)_fill" : rawValue
    }
}
