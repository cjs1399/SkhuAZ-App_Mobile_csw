//
//  E_modify.swift
//  SKHUAZ
//
//  Created by 박신영 on 2023/04/12.
//

import SwiftUI

struct thirdLecture: Codable, Equatable {
    let id: Int
    let lectureName: String
    let prfsName: String
    let classYear: Int
    let semester: Int
    let department: String
    let teamPlay: Int
    let task: Int
    let practice: Int
    let presentation: Int
    let review: String
    let userNickname: String
}


struct E_modify: View {
    @Binding var secoundLec : secondLecture // 자세히보기를 클릭하여 받아온 수강평 값.
    @Binding var selectedLectureID: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var lectureName: String = "" // 과목명
    @State private var prfsName: String = ""    // 교수님 성함
    @State private var classYear: Int = 0   // 수강년도
    @State private var semester: Int = 0   // 1 or 2 학기
    @State private var department: String = ""  // 전공구분
    @State private var is_major_required: Bool = false  // 전공필수 여부
    @State private var teamPlay: Int = 0 // 팀플비중
    @State private var task: Int = 0 // 과제량
    @State private var practice: Int = 0 // 연습
    @State private var presentation: Int = 0 // 발표
    @State private var review: String = "" // 강의총평
    @Environment(\.presentationMode) var presentationModeRoot
    @State private var scorenotice = "※ 숫자가 높을 수록 횟수/양 이 많습니다."
    @State private var name_notice = "※ 과목명과 교수님 성함은 강의계획서를 준합니다."
    @State private var skip: Bool = false
    @State var showAlert: Bool = false
    
    
    @EnvironmentObject var userData: UserData
    @StateObject var api = PostAPI()
    @State var thirdLectures: [thirdLecture] = []
    func Classyear_recover (num:Int) -> Int {
        var n = num.description.split(separator: ",")
        var s = ""
        for i in n {
            s+=i.description
        }
        return Int(s)!

    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ForEach(thirdLectures, id: \.id) { lecture in
                Group{
                    GeometryReader { geometry in
                        let maxWidth = geometry.size.width
                        let maxHeight = geometry.size.height
                        
                        NavigationView{
                            ScrollView {
                                VStack {
                                    HStack {
                                        Text("\(userData.nickname)")
                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                            .fontWeight(.semibold)
                                            .font(.system(size: 17))
                                        Text(" 님은 지금 2023-1 학기 입니다.")
                                            .font(.system(size: 17))
                                        
                                    }.padding(.top, 20)
                                    
                                    VStack{
                                        
                                        HStack {
                                            Text(name_notice)
                                                .foregroundColor(Color.red)
                                                .font(.system(size: 15))
                                        }
                                        
                                        Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                            .frame(width: 350, height: 50)
                                            .cornerRadius(10)
                                            .overlay(content: {
                                                TextField("\(lecture.lectureName)", text: $lectureName)
                                                    .padding()
                                                    .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                                                    .disableAutocorrection(true) // 자동완성 끄기
                                                    .foregroundColor(Color(hex: 0x4F4F4F))
                                            })
                                        
                                        Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                            .frame(width: 350, height: 50)
                                            .cornerRadius(10)
                                            .overlay(content: {
                                                TextField("\(lecture.prfsName)", text: $prfsName)
                                                    .padding()
                                                    .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                                                    .disableAutocorrection(true) // 자동완성 끄기
                                                    .foregroundColor(Color(hex: 0x4F4F4F))
                                            })
                                            .padding(.bottom, 20)
                                        
                                        
                                        HStack{
                                            Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                                .frame(width: 200, height: 40)
                                                .cornerRadius(10)
                                                .overlay(content: {
                                                    HStack {
                                                        Menu("\(Classyear_recover(num: lecture.classYear)) (년)") {
                                                            Button("2018년",
                                                                   action: { classYear = 2018})
                                                            Button("2019년",
                                                                   action: { classYear = 2019})
                                                            Button("2020년",
                                                                   action: { classYear = 2020})
                                                            Button("2021년",
                                                                   action: { classYear = 2021})
                                                            Button("2022년",
                                                                   action: { classYear = 2022})
                                                            Button("2023년",
                                                                   action: { classYear = 2023})
                                                        }
                                                        .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                        .font(.system(size: 13))
                                                        .fontWeight(.semibold)
                                                        .cornerRadius(10)
                                                        //                                                .padding()
                                                        //                                                .frame(width: 10, height: 50)
                                                        
                                                    }
                                                })
                                            Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                                .frame(width: 140, height: 40)
                                                .cornerRadius(10)
                                                .overlay(content: {
                                                    HStack {
                                                        Menu("\(lecture.semester)학기") {
                                                            Button("1학기",
                                                                   action: { semester = 1})
                                                            Button("2학기",
                                                                   action: { semester = 2})
                                                            
                                                            
                                                        }
                                                        .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                        .font(.system(size: 15))
                                                        .fontWeight(.semibold)
                                                        .cornerRadius(10)
                                                    }
                                                })
                                        }
                                        //학과
                                        Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                            .frame(width: 350, height: 40)
                                            .cornerRadius(10)
                                            .overlay(content: {
                                                HStack {
                                                    Menu("\(lecture.department)") {
                                                        Button("소프트웨어공학",
                                                               action: { department = "소프트웨어공학"})
                                                        Button("정보통신공학",
                                                               action: { department = "정보통신공학"})
                                                        Button("컴퓨터공학",
                                                               action: { department = "컴퓨터공학"})
                                                        Button("인공지능공학",
                                                               action: { department = "인공지능공학"})
                                                        
                                                    }
                                                    .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                    .font(.system(size: 15))
                                                    .fontWeight(.semibold)
                                                    .cornerRadius(10)
                                                }
                                            })
                                            .padding(.bottom, 20)
                                        
                                        VStack {
                                            Text(scorenotice)
                                                .foregroundColor(Color.red)
                                                .font(.system(size: 15))
                                            
                                            
                                            
                                            HStack{
                                                Text("팀플비중")
                                                    .padding(.leading, 25)
                                                    .padding([.leading, .trailing])
                                                Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                                    .frame(width: 170, height: 40)
                                                    .cornerRadius(10)
                                                    .overlay(content: {
                                                        HStack {
                                                            Menu("\(lecture.teamPlay)") {
                                                                Button("1점",
                                                                       action: { teamPlay = 1})
                                                                Button("2점",
                                                                       action: { teamPlay = 2})
                                                                Button("3점",
                                                                       action: { teamPlay = 3})
                                                                Button("4점",
                                                                       action: { teamPlay = 4})
                                                                Button("5점",
                                                                       action: { teamPlay = 5})
                                                                
                                                            }
                                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                            .font(.system(size: 15))
                                                            .fontWeight(.light)
                                                            .cornerRadius(10)
                                                        }
                                                    })
                                            }
                                            HStack{
                                                Text("과제량")
                                                    .padding(.leading, 40)
                                                    .padding([.leading, .trailing])
                                                Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                                    .frame(width: 170, height: 40)
                                                    .cornerRadius(10)
                                                    .overlay(content: {
                                                        HStack {
                                                            Menu("\(lecture.task)") {
                                                                Button("1점",
                                                                       action: { task = 1})
                                                                Button("2점",
                                                                       action: { task = 2})
                                                                Button("3점",
                                                                       action: { task = 3})
                                                                Button("4점",
                                                                       action: { task = 4})
                                                                Button("5점",
                                                                       action: { task = 5})
                                                                
                                                            }
                                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                            .font(.system(size: 15))
                                                            .fontWeight(.light)
                                                            .cornerRadius(10)
                                                        }
                                                    })
                                            }
                                            
                                            HStack{
                                                Text("실습량")
                                                    .padding(.leading, 40)
                                                    .padding([.leading, .trailing])
                                                Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                                    .frame(width: 170, height: 40)
                                                    .cornerRadius(10)
                                                    .overlay(content: {
                                                        HStack {
                                                            Menu("\(lecture.practice)") {
                                                                Button("1점",
                                                                       action: { practice = 1})
                                                                Button("2점",
                                                                       action: { practice = 2})
                                                                Button("3점",
                                                                       action: { practice = 3})
                                                                Button("4점",
                                                                       action: { practice = 4})
                                                                Button("5점",
                                                                       action: { practice = 5})
                                                                
                                                            }
                                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                            .font(.system(size: 15))
                                                            .fontWeight(.light)
                                                            .cornerRadius(10)
                                                        }
                                                    })
                                            }
                                            HStack{
                                                Text("발표량")
                                                    .padding(.leading, 40)
                                                    .padding([.leading, .trailing])
                                                Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                                    .frame(width: 170, height: 40)
                                                    .cornerRadius(10)
                                                    .overlay(content: {
                                                        HStack {
                                                            Menu("\(lecture.presentation)") {
                                                                Button("1점",
                                                                       action: { presentation = 1})
                                                                Button("2점",
                                                                       action: { presentation = 2})
                                                                Button("3점",
                                                                       action: { presentation = 3})
                                                                Button("4점",
                                                                       action: { presentation = 4})
                                                                Button("5점",
                                                                       action: { presentation = 5})
                                                                
                                                            }
                                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                            .font(.system(size: 15))
                                                            .fontWeight(.light)
                                                            .cornerRadius(10)
                                                        }
                                                    })
                                            }
                                        }.padding(.bottom,20)
                                        
                                        HStack {
                                            TextEditor(text: $review)
                                                .padding(.bottom, 50)
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 15))
                                                .lineSpacing(5) //줄 간격
                                                .frame(width: maxWidth*0.9, height: 300)
                                                .border(Color(hex: 0x9AC1D1), width: 1)
                                                .cornerRadius(0)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    //전체 큰 네모박스
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(hex: 0x9AC1D1), lineWidth: 1)
                                            .frame(width: maxWidth*0.95)
                                    )
                                    .padding(.bottom,20)
                                    
                                    HStack {
                                        //취소 버튼
                                        Button(action: {
                                            print("목록버튼 클릭")
                                            //                                        skip = true
                                            presentationMode.wrappedValue.dismiss()
                                        })
                                        {
                                            Text("취소")
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 15))
                                                .frame(width: maxWidth*0.4, height: 40)
                                                .cornerRadius(10)
                                                .background(Color(hex: 0xC28D8D))
                                                .cornerRadius(10)
                                        }
                                        .background(
                                            NavigationLink(destination: EvaluationView(selectedLectureID: 0), isActive: $skip) {
                                                
                                                EmptyView()
                                            }
                                        )
                                        
                                        //저장 버튼
                                        Button(action: {
                                            if lectureName != "" && prfsName != "" && classYear != 0 && semester != 0 && department != "" && teamPlay != 0 && task != 0 && practice != 0 && presentation != 0 && presentation != 0 && review != ""{
                                                
//                                                let parameters: [String: Any] = ["lectureName": lectureName, "prfsName": prfsName, "classYear": Int(classYear)!, "semester": Int(semester)!, "department": department, "is_major_required": is_major_required, "teamPlay": teamPlay, "task": task, "practice": practice, "presentation": presentation, "review": review]
//                                                print("강의평 Create parameters : \(parameters)")
//                                                updateData(id: selectedLectureID, parameters: parameters)
                                                updateData(id: selectedLectureID) {
                                                    presentationModeRoot.wrappedValue.dismiss()

                                                    }
                                                
                                                
                                                
                                            } else {
                                                showAlert = true
                                                print("조건을 모두 입력하여주세요.")
                                            }
                                        })
                                        {
                                            Text("수정")
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 15))
                                                .frame(width: maxWidth*0.4, height: 40)
                                                .cornerRadius(10)
                                                .background(Color(hex: 0x9AC1D1))
                                                .cornerRadius(10)
                                        }
                                        .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("조건을 모두 입력하여주세요."),
                                                message: nil,
                                                dismissButton: .default(Text("확인"))
                                            )
                                        }
                                        .foregroundColor(.white)
                                        .frame(width: 170, height: 40)
                                        .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                                        .cornerRadius(10)
                                    }
                                    .padding(.bottom, 20)
                                }
                                
                                
                                
                            }//스크롤
                        }.navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
        .onAppear {
            getLecture1(id: selectedLectureID)
            lectureName = secoundLec.lectureName
            prfsName = secoundLec.prfsName
            classYear = secoundLec.classYear
            semester = secoundLec.semester
            department = secoundLec.department
            teamPlay = secoundLec.teamPlay
            task = secoundLec.task
            practice = secoundLec.practice
            presentation = secoundLec.presentation
            review = secoundLec.review
        }
    }
    
    func getLecture1(id: Int) {
        guard let url = URL(string: "http://skhuaz.duckdns.org/evaluations/\(id)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let lecture = try decoder.decode(thirdLecture.self, from: data)
                print("Received Lecture Data: \(lecture)")
                self.thirdLectures.append(lecture) // 받아온 데이터를 배열에 추가
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func updateData(id: Int, dismissModal: @escaping () -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "http://skhuaz.duckdns.org/evaluation/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionId = userData.sessionId
        request.setValue(sessionId, forHTTPHeaderField: "sessionId")
        
        let parameters: [String: Any] = ["lectureName": lectureName, "prfsName": prfsName, "classYear": classYear, "semester": semester, "department": department, "teamPlay": teamPlay, "task": task, "practice": practice, "presentation": presentation, "review": review]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid response")
                return
            }
            
            DispatchQueue.main.async {
                dismissModal()
            }
        }
        
        task.resume()
    }
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let sessionId = userData.sessionId
//        request.setValue(sessionId, forHTTPHeaderField: "sessionId")
//
//        let parameters: [String: Any] = ["lectureName": lectureName, "prfsName": prfsName, "classYear": classYear, "semester": semester, "department": department, "teamPlay": teamPlay, "task": task, "practice": practice, "presentation": presentation, "review": review]
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
//            request.httpBody = jsonData
//        } catch {
//            print("Error serializing JSON: \(error)")
//            return
//        }
//
//        let task = session.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print("Error: \(error!)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                print("Error: Invalid response")
//                return
//            }
//
//            DispatchQueue.main.async {
//                dismissModal()
//            }
//        }
//
//        task.resume()
//    }
//    func updateData(id: Int) {
//            guard let url = URL(string: "http://skhuaz.duckdns.org/evaluation/\(id)") else {
//                fatalError("Invalid URL")
//            }
//            var request = URLRequest(url: url)
//            request.httpMethod = "PUT"
//            // Add data to the model
//            let data = try! JSONSerialization.data(withJSONObject: parameters)
//            request.httpBody = data
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
//                if let response = response as? HTTPURLResponse {
//                    if response.statusCode == 200 {
//                        DispatchQueue.main.async {
//                            // Find the updated lecture in the lectures array and update it
//                            if let index = self.thirdLectures.firstIndex(where: { $0.id == id }) {
//                                do {
//                                    let decoder = JSONDecoder()
//                                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                                    let result = try decoder.decode(thirdLecture.self, from: data!)
//                                    self.thirdLectures[index] = result
//                                    print("수정되었습니다.")
//                                } catch let error {
//                                    print("Error decoding response: \(error.localizedDescription)")
//                                }
//                            }
//                        }
//                    } else {
//                        print("서버와의 통신이 실패했습니다. \(response.statusCode) 에러")
//                    }
//                }
//            }
//            task.resume()
//    }
    
    
}
