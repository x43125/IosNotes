//
//  ContentView.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group(note: ModelData().notes[0])
            .environment(ModelData())
    }
}

#Preview {
    ContentView()
}
