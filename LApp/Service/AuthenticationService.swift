//
//  AuthenticationService.swift
//  LMessenger
//
//  Created by 곽서방 on 7/17/24.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum AuthenticationError: Error {
    case clientIDError
    case tokenError
    case invalidated
}

///viewModel과 Serivece를 Combine으로 연결 예정
protocol AuthenticationServiceType {
    func signInWithGoogle() -> AnyPublisher<User,ServiceError>
    func checkAuthenticationState() -> String?
    
}

class AuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        //firebase를 이용해 현재 유저 정보가 있는 지 체크 후 추출
        if let user = Auth.auth().currentUser {
            return user.uid
        } else { return nil }
    }
    
    //구글 로그인은 Combine을 제공하지 않기때문에 completion handler로 Puture로 Publisher를 만들 예정
    func signInWithGoogle() -> AnyPublisher<User,ServiceError> {
        // 최종적으로 하나의 값을 생성한 후 끝나는 Publisher
        Future { [weak self] promise in
            self?.signInWithGoogle { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                case let .failure(error):
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}

extension AuthenticationService {
    
    private func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void)  {
        //1. firebase client id로 google configuration object 생성
        // clientID 받아오는 작업
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthenticationError.clientIDError))
            return
        }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        //2. google login view 가져오기
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else { return }
        
        //login 진행
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result , error in
            if let error {
                completion(.failure(error))
            }
            //성공 시 id token과 access token을 이용해 credential(사용자 인증 정보) 생성
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthenticationError.tokenError))
                return
            }
            let accessToken = user.accessToken.tokenString
            //credential 생성
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: accessToken)
            //여기까지 구글 로그인 진행 완료
            
            //firebase 인증
            self?.authenticateUserWithFirebase(credential: credential, completion: completion)
        }
        
    }
    //firebase 인증 및 user 함수
    private func authenticateUserWithFirebase(credential: AuthCredential,completion: @escaping (Result<User,Error>) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let result else {
                completion(.failure(AuthenticationError.invalidated))
                return
            }
            //user 생성
            let firebaseUser = result.user
            let user: User = .init(
                id: firebaseUser.uid,
                name: firebaseUser.displayName ?? "",
                phoneNumber: firebaseUser.phoneNumber,
                profileURL: firebaseUser.photoURL?.absoluteString
            )
            completion(.success(user))
        }
        
    }
}

class StubAuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        return nil
    }

    func signInWithGoogle() -> AnyPublisher<User,ServiceError> {
        Empty().eraseToAnyPublisher()
        
    }
    
}
