//
//  EvaluationView.swift
//  PBC
//
//  Created by 봉주헌 on 2023/03/06.
//
import Charts
import SwiftUI


struct EvaluationView: View {
    
    
    @State var input: String = ""
    @State var Evalution_write = false
    @EnvironmentObject var userData: UserData
    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let maxHeight = geometry.size.height
            NavigationView{
                
                VStack{
                    /**검색창**/
                    HStack{
                        TextField("강의를 검색해주세요", text: $input)
                            .padding(.leading)
                            .frame(width: 300, height: 50)
                            .background(Color(.white))
                            .border(Color(hex: 0x9AC1D1),width: 5)
                            .cornerRadius(10)
                        
                        Image("검색버튼")
                            .padding()
                            .frame(width: 50, height: 30)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    
                    /**전공 선택 파트**/
                    HStack{
                        Spacer()
                        
                        Major_Box()
                        Text("")
                            .frame(width:20)
                        VStack(alignment: .center) {
                            Text("")
                                .frame(height: 15)
                            Button(action: {
                                
                                Evalution_write = true
                                
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.bottom, 5)
                                    .foregroundColor(Color(hex: 0x9AC1D1))
                                    .padding(.trailing, 15)
                                    .frame(width: 50, height: 35)
                            }
                            .padding(.bottom, 10)
                            NavigationLink(destination: EvaluationDetail().navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true), isActive: $Evalution_write) {
                                    
                                    EmptyView()
                                }
                        }
                        
//                        Spacer()
                        
                    }.padding(.bottom, 5)//2번 줄 끝
                    
                    ScrollView(.vertical, showsIndicators: false, content:  {
                        Text("")
                            .frame(height: 10)
                        LisTView()
                            
                        LisTView()
                            
                        
                    })
                    .padding()
                    .padding(.bottom, 15)
                    .border(Color(hex: 0x9AC1D1), width: 1)
                    .frame(maxWidth: .infinity)
                }                //
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}



struct EvaluationView_Previews: PreviewProvider {
    static var previews: some View {
        EvaluationView()
    }
}
