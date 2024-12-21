//
//  NoteRow.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/20.
//

import SwiftUI

struct NoteRow: View {
    
    @EnvironmentObject var modelData: ModelData
    var note: Note
    
    var body: some View {
        // 如果取不到tag则用默认tag
        let tag = modelData.tagId2Tag[note.tagId] ?? modelData.defaultTag
        
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.title3)
                .bold()
            HStack {
                // 如果是本周内的则改为展示星期几
                Text("\(note.time, formatter: dateFormatter)")
                Text(note.subTitle)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            Label(tag.name, systemImage: tag.imageName)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }        
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }()
}

#Preview {
    NoteRow(note: ModelData().notes[1])
}
