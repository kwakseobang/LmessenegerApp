//
//  LoginView.swift
//  LApp
//
//  Created by 곽서방 on 7/17/24.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Group{
                Text("로그인")
                    .font(.system(size: 28,weight: .bold))
                    .foregroundColor(.bkText_ct)
                    .padding(.top,80)
                Text("아래 제공되는 서비스로 로그인해주세요.")
                    .font(.system(size: 15))
                    .foregroundColor(.greyDeep_ct)
            }
            .padding(.horizontal,30)
            
            Spacer()
            
            Group {
                Button{
                    //TODO: google
                }label: {
                    Text("Google로 로그인")
                }
               
                Button{
                    //TODO: apple
                }label: {
                    Text("Apple로 로그인")
                }
            }
            .buttonStyle(LoginBtnStyle(textColor: .bkText_ct, borderColor: .greyLight_ct))
        }
     
    }
}

#Preview {
    LoginView()
}
