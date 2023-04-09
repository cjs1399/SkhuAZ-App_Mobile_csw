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
    
    static let shared = RestAPI()
    
    
    
    func postMethod(parameters: [String: Any]) {
        guard let url = URL(string: "http://skhuaz.duckdns.org/save/evaluation") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create model
        struct UploadData: Codable {
            let lectureName: String
            let prfsName: String
            let classYear: Int
            let semester: Int
            let is_major_required: Bool
            let department: String
            let teamPlay: String
            let task: String
            let practice: String
            let presentation: String
            let review: String
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
    
}
