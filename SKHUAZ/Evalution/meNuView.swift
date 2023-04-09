//
//  meNuView.swift
//  skhuaz
//
//  Created by 봉주헌 on 2023/03/11.
//

import SwiftUI

struct meNuView : View {
    @State private var lectureName: String = "" // 과목명
    @State private var prfsName: String = ""    // 교수님 성함
    @State private var classYear: Int = 0   // 수강년도
    @State private var semester: Int = 0   // 1 or 2 학기
    @State private var department: String = ""  // 전공구분
    @State private var is_major_required: Bool = false  // 전공필수 여부
    @State private var teamPlay: String = "" // 팀플 점수
    @State private var task: String = "" // 과제량
    @State private var practice: String = "" // 연습
    @State private var presentation: String = "" // 발표
    @State private var review: String = "" // 리뷰

    @StateObject var api = PostAPI()


    @State private var allreview: String = ""

    var body: some View {
        VStack{
            Rectangle().fill(Color(hex: 0xEFEFEF))
                .frame(width: 350, height: 40)
                .cornerRadius(10)
                .overlay(content: {
                    HStack {
                        TextField("과목명을 입력해주세요.", text: $lectureName)
                            .padding()
                        frame(width: 10, height: 50)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                            .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                            .disableAutocorrection(true) // 자동완성 끄기
                            .foregroundColor(Color(hex: 0x4F4F4F))
                        Spacer()
                    }
                })
            Rectangle().fill(Color(hex: 0xEFEFEF))
                .frame(width: 350, height: 40)
                .cornerRadius(10)
                .overlay(content: {
                    HStack {
                        TextField("교수님 성함을 입력해주세요.", text: $lectureName)
                            .padding()
                        frame(width: 10, height: 50)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                            .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                            .disableAutocorrection(true) // 자동완성 끄기
                            .foregroundColor(Color(hex: 0x4F4F4F))
                        Spacer()
                    }
                })
            HStack{
                Rectangle().fill(Color(hex: 0xEFEFEF))
                    .frame(width: 170, height: 40)
                    .cornerRadius(10)
                    .overlay(content: {
                        HStack {
                            Menu("\(classYear)") {
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
                            .foregroundColor(Color(hex: 0x4F4F4F))
                            Spacer()
                                .padding()
                                .frame(width: 10, height: 50)
                                .cornerRadius(10)
                        }
                    })
                Rectangle().fill(Color(hex: 0xEFEFEF))
                    .frame(width: 170, height: 40)
                    .cornerRadius(10)
                    .overlay(content: {
                        HStack {
                            Menu("\(semester)") {
                                Button("1학기",
                                       action: { semester = 1})
                                Button("2학기",
                                       action: { semester = 2})
                            }
                            .foregroundColor(Color(hex: 0x4F4F4F))
                            Spacer()
                                .padding()
                                .frame(width: 10, height: 50)
                                .cornerRadius(10)
                        }
                    })
            }
            Rectangle().fill(Color(hex: 0xEFEFEF))
                .frame(width: 350, height: 40)
                .cornerRadius(10)
                .overlay(content: {
                    HStack {
                        Menu("\(department)") {
                            Button("소프트웨어공학",
                                   action: { department = "소프트웨어공학"})
                            Button("정보통신공학",
                                   action: { department = "정보통신공학"})
                            Button("컴퓨터공학",
                                   action: { department = "컴퓨터공학"})
                            Button("인공지능",
                                   action: { department = "인공지능"})

                        }
                        .foregroundColor(Color(hex: 0x4F4F4F))
                        Spacer()
                            .padding()
                            .frame(width: 10, height: 50)
                            .cornerRadius(10)
                    }
                })
            HStack{
                Text("팀플유무")
                    .padding(.leading, 25)
                    .padding([.leading, .trailing])
                Rectangle().fill(Color(hex: 0xEFEFEF))
                    .frame(width: 170, height: 40)
                    .cornerRadius(10)
                    .overlay(content: {
                        HStack {
                            Menu("\(teamPlay)") {
                                Button("1",
                                       action: { teamPlay = "1"})
                                Button("2",
                                       action: { teamPlay = "2"})
                                Button("3",
                                       action: { teamPlay = "3"})
                                Button("4",
                                       action: { teamPlay = "4"})
                                Button("5",
                                       action: { teamPlay = "5"})

                            }
                            .foregroundColor(Color(hex: 0x4F4F4F))
                            Spacer()
                                .padding()
                                .frame(width: 10, height: 50)
                                .cornerRadius(10)
                        }
                    })
            }
            HStack{
                Text("과제량")
                    .padding(.leading, 40)
                    .padding([.leading, .trailing])
                Rectangle().fill(Color(hex: 0xEFEFEF))
                    .frame(width: 170, height: 40)
                    .cornerRadius(10)
                    .overlay(content: {
                        HStack {
                            Menu("\(task)") {
                                Button("1",
                                       action: { task = "1"})
                                Button("2",
                                       action: { task = "2"})
                                Button("3",
                                       action: { task = "3"})
                                Button("4",
                                       action: { task = "4"})
                                Button("5",
                                       action: { task = "5"})

                            }
                            .foregroundColor(Color(hex: 0x4F4F4F))
                            Spacer()
                                .padding()
                                .frame(width: 10, height: 50)
                                .cornerRadius(10)
                        }
                    })
            }

            HStack{
                Text("실습량")
                    .padding(.leading, 40)
                    .padding([.leading, .trailing])
                Rectangle().fill(Color(hex: 0xEFEFEF))
                    .frame(width: 170, height: 40)
                    .cornerRadius(10)
                    .overlay(content: {
                        HStack {
                            Menu("\(practice)") {
                                Button("1",
                                       action: { practice = "1"})
                                Button("2",
                                       action: { practice = "2"})
                                Button("3",
                                       action: { practice = "3"})
                                Button("4",
                                       action: { practice = "4"})
                                Button("5",
                                       action: { practice = "5"})

                            }
                            .foregroundColor(Color(hex: 0x4F4F4F))
                            Spacer()
                                .padding()
                                .frame(width: 10, height: 50)
                                .cornerRadius(10)
                        }
                    })
            }
            HStack{
                Text("발표량")
                    .padding(.leading, 40)
                    .padding([.leading, .trailing])
                Rectangle().fill(Color(hex: 0xEFEFEF))
                    .frame(width: 170, height: 40)
                    .cornerRadius(10)
                    .overlay(content: {
                        HStack {
                            Menu("\(presentation)") {
                                Button("1",
                                       action: { presentation = "1"})
                                Button("2",
                                       action: { presentation = "2"})
                                Button("3",
                                       action: { presentation = "3"})
                                Button("4",
                                       action: { presentation = "4"})
                                Button("5",
                                       action: { presentation = "5"})

                            }
                            .foregroundColor(Color(hex: 0x4F4F4F))
                            Spacer()
                                .padding()
                                .frame(width: 10, height: 50)
                                .cornerRadius(10)
                        }
                    })
            }
            TextField("강의총평 100자 제한", text: $review )
                .padding(.bottom, 50)
                .padding([.leading, .top])
                .frame(width: 350, height: 100)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )


        //저장 버튼
        Rectangle().fill(Color(hex: 0x9AC1D1))
            .frame(width: 350, height: 40)
            .cornerRadius(10)
            .overlay(content: {
                HStack {

//                    @State private var lectureName: String = "" // 과목명
//                    @State private var prfsName: String = ""    // 교수님 성함
//                    @State private var classYear: Int = 0   // 수강년도
//                    @State private var semester: Int = 0   // 1 or 2 학기
//                    @State private var department: String = ""  // 전공구분
//                    @State private var is_major_required: Bool = false  // 전공필수 여부
//                    @State private var teamPlay: String = "" // 팀플 점수
//                    @State private var task: String = "" // 과제량
//                    @State private var practice: String = "" // 연습
//                    @State private var presentation: String = "" // 발표
//                    @State private var review: String = "" // 리뷰
                    
                    Button(action: {
                        if lectureName != "" && prfsName != "" && classYear != 0 && semester != 0{

//                            let parameters: [String: Any] = ["lectureName": lectureName, "prfsName": prfsName, "classYear": classYear, "semester": semester, "department": department, "is_major_required": is_major_required, "teamPlay": teamPlay, "task": task, "practice": practice, "presentation": presentation, "review": review]
//                            print("강의평 Create parameters : \(parameters)")
//                            api.postMethod(parameters: parameters)


                            // 회원가입 api 보냈으니까 값 다 비워주기
                            lectureName = ""
                            prfsName = ""
                            classYear = 0
                            semester = 0
                            department = ""
                            is_major_required = false
                            teamPlay = ""
                            task = ""
                            practice = ""
                            presentation = ""
                            review = ""

                        } else {
                            print("조건을 모두 입력하여주세요.")
                        }
                    })
                    {
                        Text("저장")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15))
                    }
                }
            })

        //목록으로 버튼
        Rectangle().fill(Color(hex: 0xEFEFEF))
            .frame(width: 350, height: 40)
            .cornerRadius(10)
            .overlay(content: {
                HStack {
                    Button{
//                        self.presentationMode.wrappedValue.dismiss()
                    } label: {

                        Text("목록으로")
                            .foregroundColor(Color.black)
                            .font(.system(size: 15))

                    }

                }
            })
        Spacer()
    }
}


struct meNuView_Previews: PreviewProvider {
    static var previews: some View {
        meNuView()
    }
}
