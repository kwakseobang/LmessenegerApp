//
//  UserService.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import Foundation
import Combine
// UserDBReository는 이 친구를 통해 접근

protocol UserServiceType {
    func addUser(_ user: User) -> AnyPublisher<User,ServiceError>
    func getUser(_ userID: String) -> AnyPublisher<User,ServiceError>
}

class UserService: UserServiceType {
    
    
    // UserDBReository 주입 후 UserDBReository에 접근
    private var dbReository: UserDBReositoryType
    
    init(dbReository: UserDBReositoryType) {
        self.dbReository = dbReository
    }
    
    //
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        //user 값을 object로 변환해줘야댐
        dbReository.addUser(user.toObject())
            .map { user } // 저장 성공시 user 그대로 반환
            .mapError{.error($0)}
            .eraseToAnyPublisher()
    }
    
    func getUser(_ userID: String) -> AnyPublisher<User,ServiceError> {
        dbReository.getUser(userID)
            .map { $0.toModel() }
            .mapError{.error($0)}
            .eraseToAnyPublisher()
    }
}


class StubUserService: UserServiceType {
    
    func addUser(_ user: User) -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
        
    }
    
    func getUser(_ userID: String) -> AnyPublisher<User,ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
}

