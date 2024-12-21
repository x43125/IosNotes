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
    var tagId: Int
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    } ()
    
    init() {
        self.id = 0
        self.title = ""
        self.subTitle = ""
        self.content = ""
        self.time = Date()
        self.tagId = 1
    }
    
    init(id: Int, title: String, subTitle: String, content: String, time: Date, tagId: Int) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.content = content
        self.time = time
        self.tagId = tagId
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.subTitle = try container.decode(String.self, forKey: .subTitle)
        self.content = try container.decode(String.self, forKey: .content)
        self.tagId = try container.decode(Int.self, forKey: .tagId)
        
        let dateString = try container.decode(String.self, forKey: .time)
        
        if let parseDate = Note.dateFormatter.date(from: dateString) {
            time = parseDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .time, in: container, debugDescription: "Date format mismatch")
        }
    }    
}
