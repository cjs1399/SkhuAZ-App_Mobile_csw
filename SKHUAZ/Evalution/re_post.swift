import SwiftUI

struct re_post: View{
    @State private var secoundlectures: [secondLecture] = []
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Binding var isMoveViewPresented: Bool
    @State var post_id: Int
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationModePost
    
    @State private var scorenotice = "※ 숫자가 높을 수록 횟수/양 이 많습니다."
    @State private var name_notice = "※ 과목명과 교수님 성함은 강의계획서를 준합니다."
    
    
    
    var body: some View {

        VStack {
            ForEach(secoundlectures, id: \.id) { lecture in
                Group{

                    GeometryReader { geometry in
                        let maxWidth = geometry.size.width
                        let maxHeight = geometry.size.height

                            ScrollView(showsIndicators: false) {
                                VStack(alignment: .center) {
                                    Text("")
                                        .frame(height:10)

                                    


                                    HStack {
                                        HStack{
                                            Text("")
                                                .frame(width:10)
                                            Text("\(lecture.userNickname)")
                                                .foregroundColor(Color(hex: 0x9AC1D1)) //글씨색
                                                .fontWeight(.semibold)
                                                .font(.system(size: 18))
                                            Text(" 님이 작성한 글입니다.")
                                                .font(.system(size: 13))
                                        }
                                        if userData.nickname.description == lecture.userNickname {
                                            Spacer()
                                            /**삭제버튼**/
                                            Button(action: {
                                                self.showAlert = true
                                                deleteLecture(id: lecture.id)
                                            }) {
                                                Image(systemName: "trash")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .padding(.bottom, 5)
                                                    .foregroundColor(Color(hex: 0x9AC1D1))
                                                    .padding(.trailing, 15)
                                                    .frame(width: 50, height: 35)
                                            }
                                            .alert(isPresented: $showAlert) {
                                                Alert(
                                                    title: Text("게시글이 삭제되었습니다."),
                                                    message: nil,
                                                    dismissButton: .default(Text("확인")) {
                                                        // Alert를 닫고 다시 표시
                                                        self.showAlert = false
                                                        self.isMoveViewPresented = false
                                                                          }
                                                )
                                            }
                                        }
                                        else {
                                            Text("")
                                        }

                                    }
                                    .padding(.top, 5)
                                    .padding(.bottom, 10)

                                    HStack {
                                        Text(name_notice)
                                            .foregroundColor(Color.red)
                                            .font(.system(size: 15))
                                    }

                                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                        .frame(width: 350, height: 50)
                                        .cornerRadius(10)
                                        .overlay(content: {
                                            Text("\(lecture.lectureName)")
                                                .padding()
                                                .foregroundColor(Color(hex: 0x4F4F4F))
                                        })

                                    Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                        .frame(width: 350, height: 50)
                                        .cornerRadius(10)
                                        .overlay(content: {
                                            Text("\(lecture.prfsName) 교수님")
                                                .padding()
                                                .foregroundColor(Color(hex: 0x4F4F4F))
                                        })
                                        .padding(.bottom, 20)


                                    HStack{
                                        Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                            .frame(width: 200, height: 40)
                                            .cornerRadius(10)
                                            .overlay(content: {
                                                Text(String(describing: lecture.classYear)+"년도")
                                                    .padding()
                                                    .foregroundColor(Color(hex: 0x4F4F4F))
                                                    .font(.system(size: 15))
                                                    .fontWeight(.semibold)
                                                    .cornerRadius(10)
                                            })
                                        Rectangle().fill(Color(uiColor: .secondarySystemBackground))
                                            .frame(width: 140, height: 40)
                                            .cornerRadius(10)
                                            .overlay(content: {
                                                HStack {
                                                    Text("\(lecture.semester)학기")
                                                        .padding()
                                                        .foregroundColor(Color(hex: 0x4F4F4F))
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
                                                Text("\(lecture.department)과")
                                                    .padding()
                                                    .foregroundColor(Color(hex: 0x4F4F4F))
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
                                                        Text("\(lecture.teamPlay)점")
                                                            .padding()
                                                            .foregroundColor(Color(hex: 0x4F4F4F))
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
                                                        Text("\(lecture.task)점")
                                                            .padding()
                                                            .foregroundColor(Color(hex: 0x4F4F4F))
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
                                                        Text("\(lecture.practice)점")
                                                            .padding()
                                                            .foregroundColor(Color(hex: 0x4F4F4F))
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
                                                        Text("\(lecture.presentation)점")
                                                            .padding()
                                                            .foregroundColor(Color(hex: 0x4F4F4F))
                                                            .font(.system(size: 15))
                                                            .fontWeight(.light)
                                                            .cornerRadius(10)
                                                    }
                                                })
                                        }
                                    }.padding(.bottom,20)

                                    HStack {
                                            Text(String(describing: lecture.review)+"")
                                                .foregroundColor(Color(hex: 0x4F4F4F))
                                                .font(.system(size: 15))
                                                .lineSpacing(5) //줄 간격
                                                .multilineTextAlignment(.leading)
                                        .frame(width: maxWidth*0.8, height: maxHeight*0.25)
                                        .border(Color(hex: 0x9AC1D1), width: 1)
                                        .cornerRadius(10)
                                    }.padding(.bottom, 30)
                                }
                                //전체 큰 네모박스
//                                .padding()
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color(hex: 0x9AC1D1), lineWidth: 1)
//                                        .frame(width: maxWidth*0.95, height:maxHeight*0.9)
//                                )
//                                .padding(.bottom,5)

                                HStack {
                                    //취소 버튼
                                    Button(action: {
                                        print("목록버튼 클릭")
//                                        skip = true
                                        presentationModePost.wrappedValue.dismiss()
                                    })
                                    {
                                        Text("목록으로")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 15))
                                            .frame(width: maxWidth*0.6, height: 40)
                                            .cornerRadius(10)
                                            .background(Color(hex: 0x9AC1D1))
                                            .cornerRadius(10)
                                    }

                                }
                            }.padding()



                    }
                }


            }
        }
        .onAppear {
            getLecture(id: post_id)
            
        }
    }
    
    func getLecture(id: Int) {
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
                let lecture = try decoder.decode(secondLecture.self, from: data)
                print("Received Lecture Data: \(lecture)")
                self.secoundlectures.append(lecture) // 받아온 데이터를 배열에 추가
                print(lecture)
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    
    func deleteLecture(id: Int) {
        guard let url = URL(string: "http://skhuaz.duckdns.org/evaluation/\(id)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let sessionId = userData.sessionId
        request.addValue(sessionId, forHTTPHeaderField: "sessionId")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                        // Remove the deleted lecture from the lectures array
                        if let index = self.secoundlectures.firstIndex(where: { $0.id == id }) {
                            self.secoundlectures.remove(at: index)
                        }
                        print("삭제했습니다.")
                        self.presentationModePost.wrappedValue.dismiss()
                        
                    }
                } else {
                    print("서버와의 통신이 실패했습니다. \(response.statusCode) 에러")
                    showAlert = true
                }
            }
        }
        task.resume()
    }
    
    
    
}

struct secondLecture: Codable {
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
