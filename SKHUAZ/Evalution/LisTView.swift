import Foundation
import SwiftUI

struct LisTView: View {
    @State var test: String = ""
    @State var testpoint: Int = 4
    
    @StateObject private var postcall = PostAPI.shared
    
    var body: some View{
        
//        let lectureName: String
//        let prfsName: String
//        let classYear: String
//        let semester: String
//        let department: String
//        let is_major_required: Bool
//        let teamPlay: String
//        let task: String
//        let practice: String
//        let presentation: String
//        let review: String
        
//        NavigationView{
//                    List{
//
//                        ForEach(network.posts, id: \.self) { result in
//                            HStack{
//                                Text(result.lectureName)
//                                    .bold()
//                            }.padding(3)
//                        }
//                    }
//                }.onAppear {
//                    network.fetchData()
//                }
        
        Button(action: {
            // 이메일, 비밀번호 로그인 api 파라미터로 보내주기
            postcall.fetchData()
            
        }) {
            Text("불러오기 테스트")
                .frame(width: 330, height: 10)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                .cornerRadius(10)
        }
        
        Group{
            VStack{
                Group{
                    HStack{
                        Text("강의명 | 교수명 | 수강학기")
                        Spacer()
                        Text("☆★★★★")
                    }
                    .font(.system(size: 12))
                    .padding()
                }
                .frame(width: 320, height: 40)
                .background(Color(uiColor: .secondarySystemBackground))
                Group{
                    HStack{
                        VStack(alignment:.trailing, spacing: 8){
                            Text("팀플 유무")
                            Text("과제량")
                            Text("실습량")
                            Text("발표량")
                        }
                        .font(.system(size: 12))
                        VStack(alignment:.leading){
                            Text("5점 기준 그래프")
                                .frame(width: 260, height: 15)
                                .background(Color(hex: 0x9AC1D1))
                            Text("3점 기준 그래프")
                                .frame(width: 156, height: 15)
                                .background(Color(hex: 0x9AC1D1))
                            Text("1점")
                                .frame(width: 52, height: 15)
                                .background(Color(hex: 0x9AC1D1))
                            chartView(point: $testpoint)
                        }
                        .frame(width: 260, height: 90)
                        .background(Color(uiColor: .secondarySystemBackground))

                    }
                }
                .frame(width: 320, height: 100)
                HStack{
                    Text("작성자 | 작성일")
                        .padding(.leading, 15)
                    Spacer()
                }
                .font(.system(size: 12))

            }.padding()
        }
        .frame(width: 350)
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(hex: 0x9AC1D1), lineWidth: 2))
    }
}
struct chartView: View{
    @Binding var point: Int
    var body: some View{
        if point == 1 {
            Text("1")
                .frame(width: 52, height: 15)
                .background(Color(hex: 0x9AC1D1))
        }
        else if point == 2 {
            Text("2")
                .frame(width: 104, height: 15)
                .background(Color(hex: 0x9AC1D1))
        }
        else if point == 3 {
            Text("3")
                .frame(width: 156, height: 15)
                .background(Color(hex: 0x9AC1D1))
        }
        else if point == 4 {
            Text("4")
                .frame(width: 208, height: 15)
                .background(Color(hex: 0x9AC1D1))
        }
        else if point == 5 {
            Text("5점테스트")
            .frame(width: 260, height: 15)
            .background(Color(hex: 0x9AC1D1))
        }
    }
}



struct LisTView_Previews: PreviewProvider {
    static var previews: some View {
        LisTView()
    }
}
