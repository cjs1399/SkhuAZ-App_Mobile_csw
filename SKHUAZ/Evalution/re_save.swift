import SwiftUI

struct re_save: View{
    //    @State private var SaveLectures: [SaveLecture] = []
    
    let resaveLectures: SaveLecture?
    
    
     @State private var lectureName: String = ""
     @State private var prfsName: String = ""
     @State private var classYear: Int = 0
     @State private var semester: Int = 0
     @State private var department: String = ""
     @State private var teamPlay: Int = 0
     @State private var task: Int = 0
     @State private var practice: Int = 0
     @State private var presentation: Int = 0
     @State private var review: String? = ""
     @State private var userNickname: String = ""
    
    
    
    @State var save_id: Int
    var body: some View{
        Group{
            Text("이번엔 너가 나와야해~")
            Text("\(save_id)")
            TextField("과목명을 입력해주세요", text: $lectureName)

        }
        .onAppear{
            lectureName = resaveLectures?.lectureName ?? ""
        }
    }
}
    
    
