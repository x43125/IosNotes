//
//  Test.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/18.
//
import SwiftUI

// 定义一个结构体
struct MyData {
    var description: String
}

struct Test: View {
    // 使用 @State 管理 MyData 的实例
    @State private var myData = MyData(description: "hello world")
    
    var body: some View {
        VStack {
            Text("Edit Description:")
                .font(.headline)
            
            // 使用 TextEditor 绑定到结构体的 description 字段
            TextEditor(text: $myData.description)
                .border(Color.gray, width: 1)
                .padding()
            
            // 显示当前输入的 description
            Text("Current Description: \(myData.description)")
                .padding()
        }
        .padding()
    }
}


#Preview {
    Test()
}
