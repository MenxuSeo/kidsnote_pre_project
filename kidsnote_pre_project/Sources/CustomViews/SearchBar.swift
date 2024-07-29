//
//  SearchBar.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  @State private var isEditing = false
  
  var body: some View {
    HStack {
      HStack {
        TextField("Play 북에서 검색", text: $text) { editing in
          isEditing = editing
        }
        
        if isEditing {
          Button(action: {
            text = ""
          }) {
            SFSymbol(type: .x)
              .foregroundColor(.gray)
          }
        }
      }
      .padding(.horizontal)
      .padding(.vertical, 8)
    }
    .padding(.horizontal)
  }
}
