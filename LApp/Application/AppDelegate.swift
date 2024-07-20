//
//  AppDelegate.swift
//  LApp
//
//  Created by 곽서방 on 7/17/24.
//

import SwiftUI
import FirebaseCore



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      //파베와 연결
    FirebaseApp.configure()

    return true
  }
}
