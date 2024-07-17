//
//  Services.swift
//  LMessenger
//
//  Created by 곽서방 on 7/17/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    
    init() {
        self.authService = AuthenticationService()
    }
}

//프리뷰용 Service Type
class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    
    
}
