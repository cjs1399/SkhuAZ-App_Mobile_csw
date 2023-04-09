//
//  EvaluationDetailView.swift
//  skhuaz
//
//  Created by 봉주헌 on 2023/03/11.
//

import SwiftUI

struct EvaluationDetail: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            VStack {
                Text("촉촉한 초코칩 님은 지금 2023-1 학기 입니다.")
                    .font(.system(size: 17))
                    .padding(.top, 20)
                meNuView()
                
                
                
            }
        }
    }
}
