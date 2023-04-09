//
//  SettingView.swift
//  pbch
//
//  Created by 문인호 on 2023/03/13.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var api = RestAPI.shared
    @EnvironmentObject var userData: UserData
    @State private var isactive:Bool = false
    @State var loginSuccess = RestAPI.LogineSuccess
    
    
    var body: some View {
        NavigationView{
            VStack(spacing: 30){
                Image("skhuazbanner")
                    .resizable()
                    .frame(width: 400, height: 200)
                    .padding(.bottom, 5)
                NavigationLink {
                    authView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                } label: {
                    HStack{
                        Image("setprofile")
                            .resizable()
                            .frame(width: 40,height: 40,alignment: .leading)
                        Text("프로필 편집")
                    }
                }
                .buttonStyle(redSettingecButton())
                
                NavigationLink {
                    communityRuleView()
                } label: {
                    HStack{
                        Image("communityrule")
                            .resizable()
                            .frame(width: 40,height: 40,alignment: .leading)
                        Text("이용 규칙")
                    }                    }
                .buttonStyle(redSettingecButton())
                
                
                //로그아웃 버튼
                Button(action: {
                    // 이메일, 비밀번호 로그인 api 파라미터로 보내주기
                    RestAPI.LogineSuccess = false
                    print("현재 loginsuccess값 : \(RestAPI.LogineSuccess)")
                    api.logout() { value in
                        if value {
                            isactive = true // 이동할 수 있도록 isActive 변수를 true로 설정
                        } else {
                            print("에러발생")
                        }
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack{
                        Image(systemName: "arrowshape.turn.up.left.circle")
                            .resizable()
                            .frame(width: 30,height: 30,alignment: .leading)
                        Text("로그아웃")
                    }
                }
//                .background(
//                    NavigationLink(destination: ContentView(), isActive: $isactive) {
//                        EmptyView()
//                    }
//                )
                .buttonStyle(redSettingecButton())
                
                
                
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("회원탈퇴")
                    
                }
                .buttonStyle(redSettingecButton())
                
                NavigationLink {
                } label: {
                    HStack{
                        Text("")
                            .frame(width: 40,height: 40,alignment: .leading)
                        
                    }
                    
                }
                
                .foregroundColor(.mainButtonColor)
                Text("© 2023. ( PBCH^2YM ) all right reserved")
                Text("")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
