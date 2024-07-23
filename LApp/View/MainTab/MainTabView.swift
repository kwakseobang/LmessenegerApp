//
//  MainTabView.swift
//  LApp
//
//  Created by 곽서방 on 7/17/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var container: DIContainer
    @State var selectedTab: MainTabType = .home
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Group{
                    switch tab {
                    case .home:
                        HomeView(homeViewModel: .init(container: container, userID: authViewModel.userID ?? ""))
                    case .chat:
                        ChatListView()
                    case .phone:
                        //구현 안할예정
                        Color.blackFix_ct
                        
                    }
                }
                .tabItem {
                    Label(tab.title, image: tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
        .tint(.bkText_ct)
    }
    //탭바의 틴트 컬러 바꿀려면 UITabbar에 접근해서 바꿔야함
    init() {
        UITabBar.appearance().unselectedItemTintColor =
        UIColor(Color.bkText_ct)
    }
}

#Preview {
    MainTabView()
}
