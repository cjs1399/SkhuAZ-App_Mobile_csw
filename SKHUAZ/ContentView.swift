//
//  ContentView.swift
//  SKHUAZ
//
//  Created by 천성우 on 2023/03/12.


import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = true
    @State var loginSuccess = RestAPI.LogineSuccess
    
    var body: some View {
        ZStack {
            
            if isActive {
                if loginSuccess {
                    TabbarView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                } else {
                    LoginView(login_onoff: false)
                }
            } else {
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
