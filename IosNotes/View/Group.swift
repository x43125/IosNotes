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
    
    var body: some View {
        // TODO: 之后再改
//        SearchBar(text: $text, placeholder: "搜索")
        
        NavigationSplitView {
            List {
                ForEach (modelData.tagId2Notes.keys.sorted(), id: \.self) { tagId in
                    let notes = modelData.tagId2Notes[tagId] ?? []
                    TagNotes(notes: notes, tagId: tagId)
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
