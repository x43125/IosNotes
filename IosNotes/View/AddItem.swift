//
//  AddItem.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/20.
//

import SwiftUI

struct AddItem: View {
    
//    @Environment(\.)
    
    @EnvironmentObject var modelData: ModelData
    
    
    @State var title: String = ""
    @State var content: String = ""
    @State var createTime: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .font(.system(size: 50))
                    .bold()
                    
                Divider()
                
                if content.isEmpty {
                    Text("Enter something...")
                        .padding(.top, 10)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                TextEditor(text: $content)
                    .font(.system(size: 20))
                
            }
            .padding()
            .navigationTitle("Add a Item")
            
        }
        .navigationBarItems(trailing: Button("Save"){
            print("save success!!!")
            // 保存到items里
            modelData.addItem(title: title, subTitle: "", content: content, time: createTime)
        })
    }
}

#Preview {
    AddItem()
}
