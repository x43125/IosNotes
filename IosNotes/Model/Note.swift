//
//  Note.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/18.
//

import Foundation
import SwiftUI

struct Note: Identifiable, Codable, Hashable {
    var id: Int
    var title: String
    var subTitle: String
    var content: String
    var time: Date
//    var tagId: Int
    var tag: Tag
    
    struct Tag: Identifiable, Codable, Hashable {
        var id: Int
        var name: String
        var imageName: String
        
        var image: Image {
            Image(systemName: imageName)
        }
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    } ()
    
    init(id: Int, title: String, subTitle: String, content: String, time: Date, tag: Tag) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.content = content
        self.time = time
        self.tag = tag
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.subTitle = try container.decode(String.self, forKey: .subTitle)
        self.content = try container.decode(String.self, forKey: .content)
//        self.tagId = try container.decode(Int.self, forKey: .tagId)
        self.tag = try container.decode(Note.Tag.self, forKey: .tag)
        
        let dateString = try container.decode(String.self, forKey: .time)
        
        if let parseDate = Note.dateFormatter.date(from: dateString) {
            time = parseDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .time, in: container, debugDescription: "Date format mismatch")
        }
    }
    
}
