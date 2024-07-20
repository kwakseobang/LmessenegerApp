//
//  AuthenticationViewModel.swift
//  LMessenger
//
//  Created by 곽서방 on 7/17/24.
//

import Foundation
import Combine
//인증 상태를 나타내는 열거형
enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    enum Action {
        case googleLogin
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    var userID: String?
    
   
    private var container: DIContainer  //service에 접근할수있도록 연결해주는 작업  DIContainer를 통해 Service에 접근할 예정
    private var subscriptions = Set<AnyCancellable>() // 구독권들 관리
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .googleLogin:
            container.services.authService.signInWithGoogle()
            //요청하는 작업 sink 사용 시 구독권 방출
                .sink { completion in
                    // TODO: 실패 시
                } receiveValue: { [weak self] user in
                    //viewmodel에서 User 정보를 가지고 있게 함
                    self?.userID = user.id
                }.store(in: &subscriptions)
            

        }
    }
}
