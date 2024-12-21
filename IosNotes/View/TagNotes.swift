//
//  TagNotes.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/22.
//

import SwiftUI

struct TagNotes: View {
    
    @Environment(ModelData.self) var modelData
    var notes: [Note]
    var tagId: Int
    
    var body: some View {
        @Bindable var modelData = modelData
        
        Section(header: Text(modelData.tagId2Tag[tagId]?.name ?? "")
            .font(.title3)
            .bold()
            .padding(.leading, -20)
            .foregroundColor(.primary)) {
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
                    modelData.deleteItem(at: indexSet, tagId: tagId)
                }
                .onMove { indices, newOffset in
                    modelData.moveItem(from: indices, to: newOffset, tagId: tagId)
                }
            }
    }
}

#Preview {
    let modelData = ModelData()
    return TagNotes(notes: ModelData().tagId2Notes[ModelData().defaultTagId] ?? [], tagId: ModelData().defaultTagId)
        .environment(modelData)
}
