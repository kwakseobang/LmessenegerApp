//
//  ContentView.swift
//  LMessenger
//
//  Created by 곽서방 on 7/17/24.
//

import SwiftUI
//인증을 나타내는 상태를 뷰모델에 츄가하여 상태에따라 뷰를 분기하는 작업까지
struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticationViewModel 
    var body: some View {
        switch authViewModel.authenticationState {
        case .authenticated:
            // TODO: - MainView
            MainTabView()
        case .unauthenticated:
            //TODO: - LoginView
            LoginIntroView()
                .environmentObject(authViewModel) // 주입
        }
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
}
