//
//  Tag.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/21.
//

import Foundation
import SwiftUI

struct Tag: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var imageName: String
    
    var image: Image {
        Image(systemName: imageName)
    }
    
    init() {
        self.id = 1
        self.name = ""
        self.imageName = ""
    }
    
    init(id: Int, name: String, imageName: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageName = try container.decode(String.self, forKey: .imageName)
    }
}
