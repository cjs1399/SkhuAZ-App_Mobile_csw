//
//  ContentView.swift
//  SKHUAZ
//
//  Created by 천성우 on 2023/03/12.


import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    @State var loginSuccess = false
    var body: some View {
        ZStack {
            Color(.blue).ignoresSafeArea()
                    if self.isActive {
                        if loginSuccess { // true면 화면 넘어감
                            TabbarView()
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                        }
                        else {
                            LoginView(login_onoff: false)
                        }
                    } else {
                        Image("logo").resizable().scaledToFit().frame(width: 120, height: 100)
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation{self.isActive = true}
                    }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
