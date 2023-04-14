import SwiftUI


struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signup = false
    @StateObject var api = RestAPI.shared
    @EnvironmentObject var userData: UserData
    @State private var error = false
    @State var login_onoff: Bool = false
    @State var loginError: Bool = false
    var alertMessage = "이메일, 비밀번호를 확인하여주십시오."
    @Environment(\.presentationMode) var presentationMode
    
    func logintoggle() {
        login_onoff = RestAPI.LogineSuccess
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                Image("SKHUAZ")
                    .resizable()
                    .frame(width: 300, height: 100)
                    .padding(.bottom)
                TextField("아이디를 입력해주세요", text: $email)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none) // 자동으로 대문자 설정 안하기
                    .disableAutocorrection(true) // 자동완성 끄기
                SecureField("비밀번호를 입력해주세요", text: $password)
                    .padding()
                    .frame(width: 350, height: 50)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                
                Button(action: {
                    // 이메일, 비밀번호 로그인 api 파라미터로 보내주기
                    if email != "" && password != "" {
                        let parameters: [String: Any] = ["email": email, "password": password]
                        
                        
                        api.LoginSuccess(parameters: parameters, userData: userData) { value in
                            if value {
                            } else {
                                loginError = true
                            }
                        }
                        RestAPI.LogineSuccess = true
                        login_onoff = RestAPI.LogineSuccess
                    }
                    
                    else {
                        loginError = true
                    }
                    
                    
                    
                }) {
                    Text("로그인")
                        .frame(width: 315, height: 10)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 0.603, green: 0.756, blue: 0.819))
                        .cornerRadius(10)
                }
//                .alert(isPresented: $loginError) {
//                    Alert(
//                        title: Text("아이디 비밀번호를 확인해주세요."),
//                        message: nil,
//                        dismissButton: .default(Text("확인")) {
//                            // Alert를 닫고 다시 표시
//                            self.loginError = false
//                            self.presentationMode.wrappedValue.dismiss()                    }
//                    )
//                }
                if login_onoff == true && loginError == false {
                    NavigationLink(destination: TabbarView(), isActive: $login_onoff) {
                        
                        EmptyView()
                    }
                }
                HStack{
                    Spacer()
                    NavigationLink(
                        destination: SignUpView(),
                        label:{
                            Text("회원가입")
                                .font(.system(size: 15))
                                .foregroundColor(Color.gray)
                                .padding(.trailing)
                        })
                }
                // 로그인 실패 시 오류
                if error {
                    Text("아이디 또는 비밀번호 오류")
                        .foregroundColor(Color.red)
                }
            }.alert(isPresented: $loginError) {
                Alert(title: Text("로그인 오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
            }
            
            
        }.navigationBarBackButtonHidden(true)
            
        
        
        
    }
}
