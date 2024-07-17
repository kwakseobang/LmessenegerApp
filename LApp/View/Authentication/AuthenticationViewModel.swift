//
//  AuthenticationViewModel.swift
//  LMessenger
//
//  Created by 곽서방 on 7/17/24.
//

import Foundation

//인증 상태를 나타내는 열거형
enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    @Published var authenticationState: AuthenticationState = .unauthenticated
    //service에 접근할수있도록 연결해주는 작업 예정 DIContainer를 통해 Service에 접근할 예정
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
