//
//  communityRuleView.swift
//  pbch
//
//  Created by 문인호 on 2023/03/13.
//

import SwiftUI

struct communityRuleView: View {
    func title(text:String) -> some View {
        return
        HStack {
            Text("")
                .frame(width:10)
            Text("\(text)\n")
                .foregroundColor(Color(hex: 0xC28D8D))
                .font(.system(size: 20))
                .fontWeight(.heavy)
            Text("")
                .frame()
        }
    }
    
    func coment(text:String) -> some View {
        return
        HStack {
            Text("")
                .frame(width:25)
            Text("\(text)")
                .lineSpacing(10) //줄 간격
            Text("\n")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("")
                    .frame(height: 30)
                HStack {
                    Image("SKHUAZ")
                        .resizable()
                        .frame(width: 150, height: 50)
                    Text("이용규칙")
                        .font(.system(size: 30))
                }
                .padding(.bottom,10)
                VStack(alignment: .leading) {
                    Group {
                        title(text: "1. 명확하고 이해하기 쉬운 언어 사용")
                        coment(text: "* 앱 내에서는 존댓말을 사용해주세요. \n* 글자 수 제한이 있으니, 가능한 짧은 문장으로 게시글을 작성해주세요.\n* 욕설, 비속어 등은 사용을 금해주세요.\n")
                        
                        
                        title(text: "2. 앱 내 사용자들의 책임 강조")
                        coment(text: "* 앱 내에서 행동한 결과에 대한 책임은 모두 해당 사용자에게 있습니다. \n* SKHUAZ는 사용자가 작성한 게시글 등의 내용에 대해 일체의 책임을 지지 않습니다.\n")
                        
                        
                        title(text: "3. 악의적인 행동 방지")
                        
                        coment(text: "* SKHUAZ는 다른 사용자에게 폭언, 모욕, 협박, 차별, 불쾌감을 줄 수 있는 게시물 작성을 금지합니다. \n* 다른 사용자의 개인정보를 유출하는 행위는 법적인 책임이 따를 수 있으므로, 이를 금합니다.\n")
                        
                        title(text: "4. 지적재산권 존중")
                        coment(text: "* SKHUAZ는 타인의 지적재산권을 존중해야 합니다. 따라서, 타인의 저작권이 포함된 이미지, 동영상, 글 등을 무단으로 복제하거나 공유하는 것은 금합니다.\n")
                        
                        title(text: "5. 규칙 준수에 대한 제재 방안 명시")
                        coment(text: "* SKHUAZ는 이용규칙을 어기는 사용자에 대해 경고를 하고, 반복적인 경우 계정을 정지할 수 있습니다.\n* 악의적인 행위나 법적 문제를 초래하는 행위가 발견된 경우, 관련 당국에 신고할 수 있습니다.")
                    }
                }
                Text("")
                    .frame(height:20)
            }
        }
        
        
    }
}

struct communityRuleView_Previews: PreviewProvider {
    static var previews: some View {
        communityRuleView()
    }
}
