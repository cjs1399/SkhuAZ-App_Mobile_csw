//
//  authView.swift
//  pbch
//
//  Created by 문인호 on 2023/03/13.
//

import Foundation
import SwiftUI

struct authView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack{
            Image("skhuazbanner")
                .resizable()
                .frame(width: 400, height: 200)
                .padding(.bottom, 5)
            Spacer()
            HStack{
                Text("본인인증")
                    .padding(.leading, 30)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .lineLimit(2)
                Spacer()
            }
            TextField("이메일을 입력해주세요", text: $email)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
            SecureField("비밀번호를 입력해주세요", text: $password)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
            Button(action: {
                // Perform authentication here
                if email == "correct_email" && password == "correct_password" {
                    // Set isLoggedIn to true
                    isLoggedIn = true
                    // Show success alert
                    showAlert = true
                    alertMessage = "옳은 이메일과 비밀번호입니다."
                } else {
                    // Set isLoggedIn to false
                    isLoggedIn = false
                    // Show failure alert
                    showAlert = true
                    alertMessage = "이메일 혹은 비밀번호가 일치하지 않습니다."
                }
            }) {
                Text("본인인증")
                    .frame(width: 330, height: 10)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                    .cornerRadius(10)
            }
            .padding(.top)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            Spacer()
            Spacer()
        }
    }
}

struct LoginResult: Codable {
    let success: Bool
    let message: String
}

func fetchLoginStatus(email: String, password: String, completionHandler: @escaping (Bool, String?) -> Void) {
    // API endpoint
    let urlString = "http://skhuaz.duckdns.org/check-login"
    
    // 요청 생성
    var request = URLRequest(url: URL(string: urlString)!)
    request.httpMethod = "GET"
    
    // 요청 파라미터 설정
    let params: [String: Any] = [
        "email": email,
        "password": password
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    // 세션 생성
    let session = URLSession.shared
    // 데이터 태스크 실행
    let task = session.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completionHandler(false, "네트워크 오류가 발생했습니다.")
            return
        }
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(LoginResult.self, from: data)
                print(result)
                if result.success {
                    completionHandler(true, "옳은 이메일과 비밀번호입니다.")
                } else {
                    completionHandler(false, "이메일 혹은 비밀번호가 일치하지 않습니다.")
                        print(result)
                }
            } catch {
                completionHandler(false, "응답을 처리하는데 실패했습니다.")
            }
        } else {
            completionHandler(false, "응답이 없습니다.")
        }
    }
    task.resume()
}

