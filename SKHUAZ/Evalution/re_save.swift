import SwiftUI

struct re_save: View{
    //    @State private var SaveLectures: [SaveLecture] = []
    
    var resaveLectures: SaveLecture
    @State var save_id: Int
    
    
    @Environment(\.presentationMode) var presentationModeRoot
    
    @State private var lectureName: String = ""
    @State private var prfsName: String = ""
    @State private var classYear: Int = 0
    @State private var semester: Int = 0
    @State private var department: String = ""
    @State private var teamPlay: Int = 0
    @State private var task: Int = 0
    @State private var practice: Int = 0
    @State private var presentation: Int = 0
    @State private var review: String = ""
    @State private var userNickname: String = ""
    @State private var name_notice1 = "※ 과목명과 교수님 성함은 강의계획서를 준합니다."
    @State private var classYear1: String = "수강년도"
    @State private var scorenotice = "※ 숫자가 높을 수록 횟수/양 이 많습니다."
    
    
    @State var showAlert: Bool = false
    @State var select_id = 0
    @Environment(\.presentationMode) var presentationMode
    
    func Classyear_recover (num:Int) -> Int {
        var n = num.description.split(separator: ",")
        var s = ""
        for i in n {
            s+=i.description
        }
        return Int(s)!
        
    }
    
    var body: some View{
        ScrollView {
            VStack {
                HStack {
                    Text("\(userNickname)")
                        .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                    Text(" 님은 지금 2023-1 학기 입니다.")
                        .font(.system(size: 17))
                    
                }.padding(.top, 20)
                
                VStack{
                    
                    HStack {
                        Text(name_notice1)
                            .foregroundColor(Color.red)
                            .font(.system(size: 15))
                    }
                    
                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                        .frame(width: 350, height: 50)
                        .cornerRadius(10)
                        .overlay(content: {
                            TextField("\(lectureName)", text: $lectureName)
                                .padding()
                                .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                                .disableAutocorrection(true) // 자동완성 끄기
                                .foregroundColor(Color(hex: 0x4F4F4F))
                        })
                    
                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                        .frame(width: 350, height: 50)
                        .cornerRadius(10)
                        .overlay(content: {
                            TextField("\(prfsName)", text: $prfsName)
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
                                    Menu("\(classYear)(년)") {
                                        Button("2018년") {
                                            classYear = 2018
                                        }
                                        Button("2019년") {
                                            classYear = 2019
                                        }
                                        Button("2020년") {
                                            classYear = 2020
                                        }
                                        Button("2021년") {
                                            classYear = 2021
                                        }
                                        Button("2022년") {
                                            classYear = 2022
                                        }
                                        Button("2023년") {
                                            classYear = 2023
                                        }
                                        
                                    }
                                    .lineLimit(1)
                                    .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .cornerRadius(10)
                                    
                                }
                            })
                        Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                            .frame(width: 140, height: 40)
                            .cornerRadius(10)
                            .overlay(content: {
                                HStack {
                                    Menu("\(semester)학기") {
                                        Button("1학기") {
                                            semester = 1
                                        }
                                        Button("2학기") {
                                            semester = 2
                                        }
                                        
                                    }
                                    .frame(width: 140, height: 40)
                                    .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .cornerRadius(10)
                                }
                            })
                    }
                    //학과
                    
                    Rectangle()
                        .fill(Color(uiColor: .secondarySystemBackground))
                        .frame(width: 350, height: 40)
                        .cornerRadius(10)
                        .overlay(content: {
                            HStack {
                                Menu {
                                    Button("소프트웨어공학") {
                                        department = "소프트웨어공학"
                                    }
                                    Button("정보통신공학") {
                                        department = "정보통신공학"
                                    }
                                    Button("컴퓨터공학") {
                                        department = "컴퓨터공학"
                                    }
                                    Button("인공지능공학") {
                                        department = "인공지능공학"
                                    }
                                } label: {
                                    HStack {
                                        TextEditor(text:$department)
                                            .frame(height: 40)
                                            .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .cornerRadius(10)
                                    }
                                }
                         
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
                                        Menu("\(teamPlay)") {
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
                                        Menu("\(task)") {
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
                                        Menu("\(practice)") {
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
                                        Menu("\(presentation)") {
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
                    
                    TextEditor(text: $review)
                        .foregroundColor(Color.black)
                        .font(.system(size: 15))
                        .lineSpacing(5) //줄 간격
                        .padding()
                        .frame(height: 150)
                    
                    
                }
                //전체 큰 네모박스
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 1)
                )
                .padding(.bottom,20)
                
                HStack {
                    //취소 버튼
                    Button(action: {
                        print("목록버튼 클릭")
                        presentationMode.wrappedValue.dismiss()
                        //
                    })
                    {
                        Text("취소")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15))
                            .cornerRadius(10)
                            .background(Color(hex: 0xC28D8D))
                            .cornerRadius(10)
                    }
                    .foregroundColor(.white)
                    .frame(width: 170, height: 40)
                    .background(Color(hex: 0xC28D8D))
                    .cornerRadius(10)
                    
                    
                    
                    
                    
                    //저장 버튼
                    Button(action: {
                        if lectureName != "" && prfsName != "" && classYear != 0 && semester != 0 && department != "" && teamPlay != 0 && task != 0 && practice != 0 && presentation != 0 && presentation != 0 && review != ""{
                            print("현재 save_id : \(save_id)")
                            print("현재 select_id : \(select_id)")
                            
                            let parameters: [String: Any] = ["lectureName": lectureName, "prfsName": prfsName, "classYear": classYear, "semester": semester, "department": department, "teamPlay": teamPlay, "task": task, "practice": practice, "presentation": presentation, "review": review]
                            print("강의평 Create parameters : \(parameters)")
                            updateData(id: select_id, parameters: parameters)
                            presentationMode.wrappedValue.dismiss()
                            
                            
                        } else {
                            showAlert = true
                            print("조건을 모두 입력하여주세요.")
                        }
                    })
                    {
                        Text("수정")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15))
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
        .onAppear() {
            lectureName = resaveLectures.lectureName
            prfsName = resaveLectures.prfsName
            classYear = resaveLectures.classYear
            semester = resaveLectures.semester
            department = resaveLectures.department
            teamPlay = resaveLectures.teamPlay
            task = resaveLectures.task
            practice = resaveLectures.practice
            presentation = resaveLectures.presentation
            review = resaveLectures.review
            userNickname = resaveLectures.userNickname
            select_id = resaveLectures.id
        }
    }
    
    func updateData(id: Int, parameters: [String: Any]) {
        guard let url = URL(string: "http://skhuaz.duckdns.org/evaluation/\(id)") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("수정되었습니다.")
                } else {
                    print("서버와의 통신이 실패했습니다. \(response.statusCode) 에러")
                }
            }
        }
        task.resume()
    }
}
