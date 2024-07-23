//
//  HomeViewModel.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation
import FirebaseAuth
import Combine

class HomeViewModel: ObservableObject {
    
    enum Action {
        case getUser
    }
    
    @Published var myUser: User?
    @Published var users: [User] = []
    
    private var container: DIContainer
    private var userID: String
    
    private var subscriptions = Set<AnyCancellable>() // 구독권들 관리
    
    init(container: DIContainer, userID: String) {
        self.container = container
        self.userID = userID
    }
    
}

extension HomeViewModel {
    
    func send(_ action: Action) {
        switch action {
        case .getUser:
            //userid가 필요함
            container.services.userService.getUser(userID)
                .sink { completion in
                    // TODO:
                } receiveValue: { [weak self] user in
                    self?.myUser = user
                }.store(in: &subscriptions)
        }
    }
    
}
