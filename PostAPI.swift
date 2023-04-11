//
//  PostAPI.swift
//  SKHUAZ
//
//  Created by 박신영 on 2023/04/09.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

class PostAPI: ObservableObject {
    
    static let shared = PostAPI()
//    private init() { }
//    @Published var posts = [Article]()
    
    
    
    func postMethod(parameters: [String: Any]) {
        guard let url = URL(string: "http://skhuaz.duckdns.org/save/evaluation") else {
            print("Error: cannot create URL")
            return
        }
        
        
        // Add data to the model
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
    
    
        
        
        
//        func fetchData(){
//            // 요청을 보낼 URL 생성
//            guard let url = URL(string: "https://your-api-url.com/data") else {
//                fatalError("Invalid URL")
//            }
//
//            // 요청 생성
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//
//            // URLSession을 사용하여 요청 보내기
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                // 에러 처리
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
//
//                // 응답 처리
//                guard let data = data else {
//                    print("No data in response")
//                    return
//                }
//
//                // 받아온 데이터를 디코딩
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let results = try decoder.decode([Results].self, from: data)
//                    print("현재 results : \(results)")
//
//                    // 받아온 데이터 처리ㅌ
//                    for article in results.articles {
//                        print(article.id)
//                        print(article.lectureName)
//                        // 나머지 데이터도 마찬가지로 처리
//                    }
//                } catch let error {
//                    if let httpResponse = response as? HTTPURLResponse {
//                        print("Status code: \(httpResponse.statusCode)")
//                    }
//                    print("Error decoding response: \(error.localizedDescription)")
//                }
//            }.resume()
//        }
    func fetchData() {
        guard let url = URL(string: "http://skhuaz.duckdns.org/AllEvaluation") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
                request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            

            guard let data = data else {
                print("No data in response")
                return
            }
            print("현재 do catch 가기 이전 data : \(data)")
            
            

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode([Results].self, from: data)
                print("현재 results : \(results)")

                for result in results {
                    print(result.id)
                    print(result.lectureName)
                    // 나머지 데이터도 마찬가지로 처리
                }
            } catch let error {
                print("Error decoding response: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
}
struct Results: Decodable {
    let id: Int
    let lectureName: String
    let prfsName: String
    let classYear: String
    let semester: String
    let department: String
    let teamPlay: String
    let task: String
    let practice: String
    let presentation: String
    let userNickname: String
    let review: String
    let user: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case lectureName = "lecture_name"
        case prfsName = "prfs_name"
        case classYear = "class_year"
        case semester
        case department
        case teamPlay = "team_play"
        case task
        case practice
        case presentation
        case userNickname = "user_nickname"
        case review
        case user
    }
}
// MARK: - Results
//struct Results: Decodable {
//    let articles: [Article]
//}
//
//// MARK: - Article
//struct Article: Decodable, Hashable {
//    let id: Int
//    let lectureName: String
//    let prfsName: String
//    let classYear: String
//    let semester: String
//    let department: String
//    let is_major_required: Bool
//    let teamPlay: String
//    let task: String
//    let practice: String
//    let presentation: String
//    let review: String
//}


class PostData: ObservableObject {
    @Published var lectureName: String = ""
    @Published var prfsName: String = ""
    @Published var classYear: Int = 0
    @Published var semester: Int = 0
    @Published var is_major_required: Bool = false
    @Published var department: String = ""
    @Published var teamPlay: String = ""
    @Published var task: String = ""
    @Published var practice: String = ""
    @Published var presentation: String = ""
    @Published var review: String = ""
    
    func setData(from response: PostData) {
        lectureName = response.lectureName
        prfsName = response.prfsName
        classYear = response.classYear
        semester = response.semester
        is_major_required = response.is_major_required
        department = response.department
        teamPlay = response.teamPlay
        task = response.task
        practice = response.practice
        presentation = response.presentation
        review = response.review
    }
}


