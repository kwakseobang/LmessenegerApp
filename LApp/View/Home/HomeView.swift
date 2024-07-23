//
//  HomeView.swift
//  LApp
//
//  Created by 곽서방 on 7/22/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ProfileView(homeViewModel: homeViewModel)
                    .padding(.bottom,30)
                
                SearchBtnView(homeViewModel: homeViewModel)
                    .padding(.bottom,25)
                
                HStack{
                    Text("친구")
                        .font(.system(size: 16,weight: .bold))
                    Spacer()
                }
                .padding(.horizontal,30)
                
                //TODO: - 친구 목록
                if homeViewModel.users.isEmpty {
                    Spacer(minLength: 89)
                    EmptyUsersView(homeViewModel: homeViewModel)
                } else {
                    Spacer(minLength: 32)
                    UserListView(homeViewModel: homeViewModel)
                }
                
                
                
            }
            .toolbar{
                Image("bookmark")
                Image("notifications")
                Image("person_add")
                Button{
                    //TODO: setting
                }label: {
                    Image("settings")
                }
            }
        }
        .onAppear{
            homeViewModel.send(.getUser)
        }
    }
}

//MARK: - profile view
private struct ProfileView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
   fileprivate var body: some View {
       HStack{
           VStack(alignment: .leading, spacing: 7){
               Text(homeViewModel.myUser?.name ?? "이름")
                   .font(.system(size: 24,weight: .bold))
                   .foregroundColor(.bkText_ct)
               
               Text(homeViewModel.myUser?.description ?? "상태 메세지 입력")
                   .font(.system(size: 12))
                   .foregroundColor(.greyDeep_ct)
           }
           Spacer()
           
           Image("person")
               .resizable()
               .frame(width: 52,height: 52)
               .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
       }
       .padding(.horizontal,30)
    }
}

//MARK: - 검색 뷰
private struct SearchBtnView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    fileprivate var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 36)
                .background(Color.greyCool_ct)
                .cornerRadius(5)
            HStack{
                Text("검색")
                    .font(.system(size: 15))
                    .foregroundColor(.greyLightVer2_ct)
                Spacer()
            }
            .padding(.leading)
        }
        .padding(.horizontal,30)
    }
}

//MARK: - 친구 empty view
private struct EmptyUsersView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate  var body: some View {
        VStack{
            VStack(spacing:5){
                Text("친구를 추가해보세요.")
                    .foregroundColor(.bkText)
                
                Text("QR코드나 검색을 이용해서 친구를 추가해보세요.")
                    .foregroundColor(.greyDeep)
            }
            .font(.system(size: 15,weight: .bold))
            .padding(.bottom,30)
            
            Button{
                //TODO:
            }label: {
                Text("친구추가")
                    .font(.system(size: 15,weight: .bold))
                    .foregroundColor(.bkText)
                    .padding(.horizontal,20)
                    .padding(.vertical,9)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyLight)
            }
        }
    }
}


//MARK: - 친구 목록 뷰
private struct UserListView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
   fileprivate init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
   fileprivate var body: some View {
       
       VStack(alignment:.leading) {
           ForEach(homeViewModel.users, id: \.id) { user in
               HStack(spacing: 5){
                   Image(user.profileURL ?? "person")
                       .resizable()
                       .frame(width: 40,height: 40)
                       .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                   
                   Text(user.name)
                       .font(.system(size: 14,weight: .bold))
                       .foregroundColor(.bkText)
                   Spacer()
               }
           }
       }
       .padding(.horizontal,30)
    }
}

#Preview {
    HomeView(homeViewModel: .init(container: .init(services: StubService()),userID: "user1_id"))
}
