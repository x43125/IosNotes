//
//  Group.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/16.
//

import SwiftUI

struct Group: View {
    
    @Environment(ModelData.self) var modelData
    
    var note: Note
    var tagKeys: [String] {
        return modelData.tagMap.keys.sorted()
    }
    
    var body: some View {
        @Bindable var modelData = modelData
        
        // TODO: 之后再改
//        SearchBar(text: $text, placeholder: "搜索")
        
        NavigationSplitView {
            List {
                ForEach (tagKeys, id: \.self) { tagName in
                    Section(header: Text(tagName)
                        .font(.title3)
                        .bold()
                        .padding(.leading, -20)
                        .foregroundColor(.primary)) {
                            let notes = modelData.tagMap[tagName] ?? []
                            ForEach (notes, id: \.id) { note in
                                NavigationLink {
                                    // 使用 Binding 来传递 note.content
                                    NoteEditor(note: $modelData.notes[modelData.notes.firstIndex(where: { $0.id == note.id })!])
                                } label: {
                                    NoteRow(note: note)
                                        .padding(-5)
                                }
                            }
                            .onDelete { indexSet in
                                modelData.deleteItem(at: indexSet, name: tagName)
                            }
                            .onMove { indices, newOffset in
                                modelData.moveItem(from: indices, to: newOffset, name: tagName)
                            }
                        }
                }
            }
            .navigationTitle("全部备忘录")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    NavigationLink(
                        "Add",
                        destination: AddItem()
                    )
            )
        } detail: {
            Text("Choose a note")
        }
    }
    
  
}

#Preview {
    let modelData = ModelData()
    Group(note: ModelData().notes[0])
        .environment(modelData)
}
