//
//  AppDelegate.swift
//  LApp
//
//  Created by 곽서방 on 7/17/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    //google 인증 프로세스가 끝날때 애플리케이션이 수신하는 URL을 적절히 처리
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      //파베와 연결
    FirebaseApp.configure()

    return true
  }
}
