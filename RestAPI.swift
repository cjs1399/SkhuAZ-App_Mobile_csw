import Foundation
import Combine

struct SignUp: Hashable, Codable {
    
    let email: String
    let password: String
    let nickname: String
    let graduate: Bool
    let magor1: String
    let magor2: String
    let department: Bool
    let major_minor: Bool
    let double_major: Bool
}


struct Login: Hashable, Decodable {
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
//
//    enum CodingKeys: String, CodingKey {
//        case double_major = "double_major"
//        case sessionId = "sessionId"
//        case login = "login"
//        case message = "message"
//        case major_minor = "major_minor"
//        case major2 = "major2"
//        case major1 = "major1"
//        case password = "password"
//        case graduate = "graduate"
//        case nickname = "nickname"
//        case semester = "semester"
//        case department = "department"
//        case email = "email"
//    }
}


class RestAPI: ObservableObject {
    
    static let shared = RestAPI()
//    @Published var loginsuccess: Bool = false
    @Published var signup: [SignUp] = []
    @Published var login: [Login] = []
    @Published var date: String = "" //날짜
    @Published var materialResponse: String = ""
    static var sessionId: Any = ""
    
    //23.04.08 추가
    static var UserEmail: Any = ""
    @Published var posts: [Login] = []
    static var LogineSuccess: Bool = false
    
    //MARK: 회원가입
    func Signup(parameters: [String: Any]) {
        guard let url = URL(string:
                                "http://skhuaz.duckdns.org/users/new-user") else {
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let posts = try String(data: data, encoding: .utf8)!
                DispatchQueue.main.async {
                print(posts)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    //MARK: 회원탈퇴
    //    func deleteAccount(parameters: [String: Any]) {
    //        guard let url = URL(string: "http://skhuaz.duckdns.org/delete") else { return }
    //
    //        let data = try! JSONSerialization.data(withJSONObject: parameters)
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "DELETE"
    //        request.httpBody = data
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        let sessionID = getSessionID()
    //        request.addValue("JSESSIONID=\(sessionID)", forHTTPHeaderField: "Cookie")
    //        // Add session ID to HTTP headers
    //        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
    //            guard let data = data, error == nil else {
    //                return
    //            }
    //            do {
    //                let posts = try String(data: data, encoding: .utf8)!
    //                DispatchQueue.main.async {
    //                    print(posts)
    //                }
    //            }
    //            catch {
    //                print(error)
    //            }
    //        }
    //        task.resume()
    //    }
    
    
    
    //MARK: 로그인
    func LoginSuccess(parameters: [String: Any],completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string:
                                "http://skhuaz.duckdns.org/users/login") else {
            return
        }
        
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //로그인했을 때 userid에 email 값을 저장해둠
        //추후 로그아웃 했을 때에 꼭 초기화 해줘야함.
        
        RestAPI.UserEmail = parameters["email"]!
        print("로그인 된 User Email 값 : \(RestAPI.UserEmail)")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                return
                
            }
            
            do {
                let posts = try JSONDecoder().decode(Login.self, from: data)
                DispatchQueue.main.async { [self] in
                    self?.posts = [posts]
                }
                print("Login 끝나고 난 후 posts[Login] 값의 타입 : \(type(of:posts))") //로그인 구조체 타입.
                print(posts)
            }
            catch {
                print(error)
            }
            do {
                let login = try JSONDecoder().decode(Login.self, from: data)
                // 변환된 Login 객체를 사용해 필요한 작업을 수행합니다.
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    //    func logout(completion: @escaping (Bool) -> Void) {
    //        guard let url = URL(string: "http://skhuaz.duckdns.org/users/logout") else {
    //            return
    //        }
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.setValue(RestAPI.sessionId as! String, forHTTPHeaderField: "sessionId") // 세션 아이디 설정
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            guard let data = data, error == nil else {
    //                completion(false)
    //                return
    //            }
    //            do {
    //                let result = try JSONDecoder().decode(LogoutResult.self, from: data)
    //                if result.status == "success" {
    //                    RestAPI.userid = "" // userid 초기화
    //                    RestAPI.sessionId = "" // 세션 아이디 초기화
    //                    completion(true)
    //                } else {
    //                    completion(false)
    //                }
    //            } catch {
    //                completion(false)
    //            }
    //        }
    //        task.resume()
    //    }
}


class UserData: ObservableObject {
    static var double_major: Any = ""
    static var sessionId: Any = ""
    static var login: Any = ""
    static var message: Any = ""
    static var major_minor: Any = ""
    static var major2: Any = ""
    static var major1: Any = ""
    static var password: Any = ""
    static var graduate: Any = ""
    static var nickname: Any = ""
    static var semester: Any = ""
    static var department: Any = ""
    static var email: Any = ""
    
}
