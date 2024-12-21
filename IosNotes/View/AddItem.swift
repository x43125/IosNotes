//
//  AddItem.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/20.
//

import SwiftUI

struct AddItem: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modelData: ModelData
    
    @State var title: String = ""
    @State var content: String = ""
    @State var createTime: Date = Date()
    
    @State private var isAlert: Bool = false
    @State private var alertTitle: String = "content is emply!"
    
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
            .alert(isPresented: $isAlert, content: getAlert)
        }
        .navigationBarItems(trailing: Button("Save"){
            if title.isEmpty && content.isEmpty {
                isAlert = true
                return
            }
            
            print("save success!!!")
            // 保存到items里
            modelData.addItem(title: title, subTitle: "", content: content, time: createTime)
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
