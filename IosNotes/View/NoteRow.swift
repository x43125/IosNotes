//
//  NoteRow.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/20.
//

import SwiftUI

struct NoteRow: View {
    
    var note: Note
    
    var body: some View {
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
            Label(note.tag.name, systemImage: note.tag.imageName)
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
