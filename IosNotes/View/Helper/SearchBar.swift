//
//  SearchBar.swift
//  IosNotes
//
//  Created by 王详 on 2024/12/16.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State var placeholder: String
    @State private var offset: CGFloat = .zero
    
    var body: some View {
        TextField("\(placeholder)", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment:.leading
                    )
                    .padding(.leading, 8)
            )
            .padding(.horizontal, 10)
    }
}



#Preview {
    SearchBar(text: .constant("hahah"), placeholder: "搜你想看的")
}
