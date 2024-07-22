//
//  Services.swift
//  LMessenger
//
//  Created by 곽서방 on 7/17/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
    var userService: UserServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbReository: UserDBReository()) //UserDBReository 주입
        //DBReository가 프로토콜로 되어있다. 그러면 실제 구현체와 의존성이 없다 그래서 다른 구현체도 주입 가능 느슨한 결합을 위해 프로토콜로 선언
    }
}

//프리뷰용 Service Type
class StubService: ServiceType {

    
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    
}
