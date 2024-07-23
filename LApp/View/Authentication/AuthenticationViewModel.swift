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
        case checkAuthenticationState
        case logOut
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLodding: Bool = false //lodding 중
    
    var userID: String?
    
   
    private var container: DIContainer  //service에 접근할수있도록 연결해주는 작업  DIContainer를 통해 Service에 접근할 예정
    private var subscriptions = Set<AnyCancellable>() // 구독권들 관리
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
            //자동로그인 기능
        case .checkAuthenticationState:
            if let userID = container.services.authService.checkAuthenticationState() {
                self.userID = userID
                self.authenticationState = .authenticated
            }
        case .googleLogin:
            isLodding = true
            container.services.authService.signInWithGoogle()
            // TODO: - login 성공 시 유저 정보 DB에 저장
                .flatMap { user in
                    self.container.services.userService.addUser(user) // DB에 저장
                }
            //요청하는 작업 sink 사용 시 구독권 방출
                .sink { [weak self] completion in
                    // TODO: 실패 시 Progress 바 중단
                    if case .failure = completion {
                        self?.isLodding = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLodding = false
                    //viewmodel에서 User 정보를 가지고 있게 함
                    self?.userID = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscriptions)
            
        case .logOut:
            container.services.authService.logOut()
                .sink { completion  in
                    
                } receiveValue: { [weak self]  in
                    self?.authenticationState = .unauthenticated
                    self?.userID = nil
                }.store(in: &subscriptions)

        }
    }
}
