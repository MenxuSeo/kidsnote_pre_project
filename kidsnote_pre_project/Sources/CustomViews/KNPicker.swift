//
//  KNPicker.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

enum BookType: String, CaseIterable  {
  case eBook
  case 오디오북
}

struct KNPicker: View {
  @Binding var selectedBookType: BookType
  
  var body: some View {
    HStack {
      ForEach(BookType.allCases, id: \.self) { bookType in
        VStack {
          Text(bookType.rawValue)
            .font(.caption)
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedBookType == bookType ? .knBlue : Color.secondary)
            Spacer()
          KNDivider(
            color: selectedBookType == bookType ? Color.knBlue : Color.clear,
            width: 40,
            height: 4
          )
          .topRadius(Color.knBackground, cornerRadius: 20)
        }
        .onTapGesture {
          withAnimation {
            selectedBookType = bookType
          }
        }
      }
    }
    .frame(height: 20)
  }
}
