//
//  HomeViewModel.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = [.stub1, .stub2, .stub3 ]
    
}
