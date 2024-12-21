//
//  AddItem.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/20.
//

import SwiftUI

struct AddItem: View {
    
    // 用来控制比如保存后，页面跳转的
    @Environment(\.presentationMode) var presentationMode
    @Environment(ModelData.self) var modelData
    
    // 用来控制当啥都没输入就想保存的情况
    @State private var isAlert: Bool = false
    @State private var alertTitle: String = "content is emply!"
    
    // 内容
    @State var note = Note()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $note.title)
                    .font(.system(size: 50))
                    .bold()
                    
                Divider()
                
                ZStack {
                    TextEditor(text: $note.content)
                        .font(.system(size: 20))
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        })
                    
                    if note.content.isEmpty {
                        Text("Enter something!")
                            .foregroundColor(.gray)
                            .allowsHitTesting(false)
                    }
                }
                .animation(.default, value:  note.content.isEmpty)
                .onChange(of:  note.content, {
                    print("inputint...")
                })

            }
            .padding()
            .navigationTitle("Add a Item")
            .alert(isPresented: $isAlert, content: getAlert)
        }
        .navigationBarItems(trailing: Button("Save"){
            if  note.title.isEmpty &&  note.content.isEmpty {
                isAlert = true
                return
            }
            
            print("save success!!!")
            // 保存到items里
            modelData.addItem(note: note)
            presentationMode.wrappedValue.dismiss()
        })
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

#Preview {
    AddItem()
}
