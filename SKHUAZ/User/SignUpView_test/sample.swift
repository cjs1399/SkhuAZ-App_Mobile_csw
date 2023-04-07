import SwiftUI

// 로그인에 성공했을 때 서버가 반환하는 데이터 모델
struct LoginPost: Codable {
    let double_major: Bool
    let sessionId: String
    let login: Bool
    let message: String
    let major_minor: Bool
    let major2: String?
    let major1: String?
    let password: String
    let graduate: Bool
    let nickname: String
    let semester: Int
    let department: Bool
    let email: String
}

struct sample: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginResponse: LoginPost?
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Login") {
                // 로그인 요청
                performLogin()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    func performLogin() {
        // 로그인 요청을 위한 URLRequest 생성
        guard let url = URL(string: "http://skhuaz.duckdns.org/users/login") else {
            print("URL이 유효하지 않습니다.")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // 로그인 요청에 필요한 파라미터 설정
        let parameters = [
            "email": email,
            "password": password
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("파라미터를 JSON으로 변환하는데 실패했습니다.")
            return
        }
        
        // URLSession을 사용하여 로그인 요청 전송
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("로그인 요청 실패: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginPost.self, from: data)
                    // 성공적으로 디코딩된 데이터를 출력
                    print("double_major: \(loginResponse.double_major)")
                    print("sessionId: \(loginResponse.sessionId)")
                    print("login: \(loginResponse.login)")
                    print("message: \(loginResponse.message)")
                    print("major_minor: \(loginResponse.major_minor)")
                    print("major2: \(loginResponse.major2)")
                    print("major1: \(loginResponse.major1)")
                    print("password: \(loginResponse.password)")
                    print("graduate: \(loginResponse.graduate)")
                    print("nickname: \(loginResponse.nickname)")
                    print("semester: \(loginResponse.semester)")
                    print("department: \(loginResponse.department)")
                    print("email: \(loginResponse.email)")
                } catch {
                    print("로그인 데이터 디코딩 실패: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
