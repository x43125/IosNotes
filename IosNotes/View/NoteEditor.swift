//
//  NoteEditor.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/19.
//

import SwiftUI

struct NoteEditor: View {
    
    @Binding var note: Note
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $note.title)
                    .font(.system(size: 50))
                    .bold()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextEditor(text: $note.content)
                    .font(.system(size: 20))
                
                DatePicker(
                    selection: $note.time, label: {Label("创建时间", systemImage: "calendar")}
                )
            }
            .padding()
            
        }
    }
}

#Preview {
    NoteEditor(note: .constant(ModelData().notes[0]))
}
