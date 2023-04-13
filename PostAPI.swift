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
    static var isDataFetched: Bool = false
    @Published var posts: [PostData] = []
    
    
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
    
    func getLecture(id: Int, parameters: [String: Any], postData: PostData, completion: @escaping (Bool) -> ()) {
        // 로그인 API 호출
        let url = "http://skhuaz.duckdns.org/evaluations/\(id)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        AF.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                PostAPI.isDataFetched = true
                let json = JSON(value)
                print("userData 가공전 json : \(json)")
                if json != "" {
                    postData.lectureName = json["lectureName"].stringValue
                    postData.prfsName = json["prfsName"].stringValue
                    postData.classYear = json["classYear"].intValue
                    postData.semester = json["semester"].intValue
                    postData.department = json["department"].stringValue
                    postData.teamPlay = json["teamPlay"].intValue
                    postData.task = json["task"].intValue
                    postData.practice = json["practice"].intValue
                    postData.presentation = json["presentation"].intValue
                    postData.review = json["review"].stringValue
                    postData.userNickname = json["userNickname"].stringValue
                    

                    completion(true)
                    print("값 할당 성공!")
                    
                } else {
                    // 로그인 실패
                    completion(false)
                }
            case .failure(let error):
                print("로그인 실패 에러코드 : ",error)
                print(response.result)
                
                completion(false)
            }
        }
    }
    
    
    
}


class PostData: ObservableObject {
    @Published var lectureName: String = ""
    @Published var prfsName: String = ""
    @Published var classYear: Int = 0
    @Published var semester: Int = 0
    @Published var is_major_required: Bool = false
    @Published var department: String = ""
    @Published var teamPlay: Int = 0
    @Published var task: Int = 0
    @Published var practice: Int = 0
    @Published var presentation: Int = 0
    @Published var review: String = ""
    @Published var userNickname: String = ""
    
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
        userNickname = response.userNickname
    }
}

