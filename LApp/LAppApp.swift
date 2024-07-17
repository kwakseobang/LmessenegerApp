//
//  LAppApp.swift
//  LApp
//
//  Created by 곽서방 on 7/17/24.
//

import SwiftUI

@main
struct LApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //DIcontainer를 EnvironmentOJ 로 주입하기 위해서
    @StateObject var container: DIContainer = .init(services: Services())
    var body: some Scene {
        WindowGroup {
            //viewmodel를 초기화 하는 시점은 뷰를 만들 때, 왜냐 뷰모델에서 컨데이너를 초기화할떄 주입해줄 예정
            AuthenticatedView(authViewModel: .init(container: container))
                .environmentObject(container)
        }
    }
}
