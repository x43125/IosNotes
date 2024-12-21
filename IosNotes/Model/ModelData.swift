//
//  ModelData.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/18.
//

import Foundation

@Observable
class ModelData: ObservableObject {
    
//    var tags: [Note.Tag] = [
//        Note.Tag(id: 1, name: "生活", imageName: "folder"),
//        Note.Tag(id: 2, name: "工作", imageName: "laptopcomputer"),
//        Note.Tag(id: 3, name: "紧急", imageName: "star.fill")
//    ]
//    
//    var notes: [Note] = [
//        Note(id: 1, title: "浇花1", subTitle: "已经浇了1", content: "hhhh1", time: Date(), tagId: 1),
//        Note(id: 2, title: "浇花2", subTitle: "已经浇了2", content: "hhhh2", time: Date(), tagId: 2),
//        Note(id: 3, title: "浇花3", subTitle: "已经浇了3", content: "hhhh3", time: Date(), tagId: 3),
//        Note(id: 4, title: "浇花4", subTitle: "已经浇了4", content: "hhhh4", time: Date(), tagId: 1),
//        Note(id: 5, title: "浇花5", subTitle: "已经浇了5", content: "hhhh5", time: Date(), tagId: 2),
//    ]
//
    
    var defaultTag = Note.Tag(id: 1, name: "生活", imageName: "folder")
    
    var notes: [Note] = load("noteData.json")
    
    var tagMap: [String: [Note]] {
        // 分组方式修改：按时间修改
//        Dictionary (grouping: notes, by: {$0.tagId})
        Dictionary (grouping: notes, by: {$0.tag.name})
    }
    
    func deleteItem(at indexSet: IndexSet, name: String) {
        guard let first = indexSet.first else {return}
        
        if let index = notes.firstIndex(where: { $0.id == tagMap[name]![first].id }) {
            notes.remove(at: index)
        }
        
        notes.remove(atOffsets: indexSet)
    }
    
    func moveItem(from indices: IndexSet, to newOffset: Int, name: String) {
        let movedNote = tagMap[name]![indices.first!]
        notes.removeAll { $0.id == movedNote.id }
        notes.insert(movedNote, at: newOffset)
//        
//        notes.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, subTitle: String, content: String, time: Date) {
        let newItem: Note = Note(
            id: notes.count + 1,
            title: title,
            subTitle: subTitle,
            content: content,
            time: time,
            tag: defaultTag
        )
        
        notes.insert(newItem, at: 0)
    }
}


// 读取文件内容方法
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

