import SwiftUI

struct MainView: View {
    @Binding var index: Int
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                Image("Logo")
                    .resizable()
                    .frame(width: 400, height: 200)
                    .padding(.bottom, 5)
                user_data()
                    .padding(.bottom, 5)
                user_post(index: $index)
                    .padding(.bottom, 5)
                user_thumbs()
                Spacer()
            }
        }
    }
}

struct user_thumbs: View{
    var body: some View{
        VStack{
            HStack{
                Text("최근 진행한 선수과목제도")
                Spacer()
                
            }
            .font(.system(size: 10))
            .foregroundColor(Color(hex: 0x7D7D7D))
            Divider()
                .background(Color(hex: 0x4F4F4F))
            Group{
                Group{
                    VStack{
                        HStack{
                            Text("소프트웨어공학전공")
                            Spacer()
                        }
                        HStack{
                            Text("자바프로그래밍, 웹개발 입문 > 자료구조, 알고리즘 > 자바프로젝트")
                            Spacer()
                        }
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                Group{
                    VStack{
                        HStack{
                            Text("소프트웨어공학전공")
                            Spacer()
                        }
                        HStack{
                            Text("자바프로그래밍, 웹개발 입문 > 자료구조, 알고리즘 > 자바프로젝트")
                            Spacer()
                        }
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
            }
            .font(.system(size: 10))
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}


struct user_post: View{
    @Binding var index: Int
    var body: some View{
        VStack{
            HStack{
                Text("내가 최근 쓴 강의평")
                Spacer()
                Button {
                    self.index = 1
                } label: {
                    Text("더 보기")
                }
            }
            .font(.system(size: 10))
            .foregroundColor(Color(hex: 0x7D7D7D))
            Divider()
                .background(Color(hex: 0x4F4F4F))
            Group{
                Group{
                    HStack{
                        Text("강의명 | 교수님명")
                        Spacer()
                        Text("☆★★★★")
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
                Group{
                    HStack{
                        Text("강의명 | 교수님명")
                        Spacer()
                        Text("☆★★★★")
                    }
                    .padding()
                }
                .frame(width: 350, height: 50)
                .background(Color(uiColor: .secondarySystemBackground))
            }
            .font(.system(size: 12))
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct user_data: View{
    @StateObject var Login = RestAPI()
    var body: some View{
        
        
        
        
                        ForEach(Login.posts, id: \.self) { result in
                            UserData.email = result.email
                            }
    }
}
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
