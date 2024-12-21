//
//  ModelData.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/18.
//

import Foundation

@Observable
class ModelData: ObservableObject {
    
//    var tags: [Tag] = [
//        Tag(id: 1, name: "生活", imageName: "folder"),
//        Tag(id: 2, name: "工作", imageName: "laptopcomputer"),
//        Tag(id: 3, name: "紧急", imageName: "star.fill")
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
  
    // 默认类型
    var defaultTagId = 1
    var defaultTag = Tag(id: 1, name: "default", imageName: "folder")
    
    // 获取tags，notes（以后可以改为存、读数据库）
    var tags: [Tag] = load("TagData.json")
    var notes: [Note] = load("NoteData.json")
    
    // tagId:[Note]
    var tagId2Notes: [Int: [Note]] {
        Dictionary (grouping: notes, by: {$0.tagId})
    }
    
    // id:Tag
    var tagId2Tag: [Int: Tag] {
        Dictionary (uniqueKeysWithValues: tags.map { ($0.id, $0) })
    }
    
    // 删除item
    func deleteItem(at indexSet: IndexSet, tagId: Int) {
        guard let first = indexSet.first else {return}
        
        if let index = notes.firstIndex(where: { $0.id == tagId2Notes[tagId]![first].id }) {
            notes.remove(at: index)
        }
        
        notes.remove(atOffsets: indexSet)
    }
    
    // 移动item
    func moveItem(from indices: IndexSet, to newOffset: Int, tagId: Int) {
        let movedNote = tagId2Notes[tagId]![indices.first!]
        notes.removeAll { $0.id == movedNote.id }
        notes.insert(movedNote, at: newOffset)
    }
    
    func addItem(note: Note) {
        let newItem: Note = Note(
            id: notes.count + 1,
            title: note.title,
            subTitle:  note.subTitle,
            content: note.content,
            time:  note.time,
            tagId:  note.tagId
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

