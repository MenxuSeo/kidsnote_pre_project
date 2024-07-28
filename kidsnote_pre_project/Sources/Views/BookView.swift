//
//  BookView.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

struct BookView: View {
  let book: Book
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
      HStack {
        ImageCache.shared.getImage(forKey: book.thumbnail?.absoluteString)?
          .resizable()
          .frame(width: 100, height: 130)
        VStack {
          Text(book.title ?? "")
          Text(book.title ?? "")
          Text(book.title ?? "")
        }
      }
      Divider()
      HStack {
        Text("무료 샘플")
        Text("전체 도서 구매하기")
      }
      Divider()
      VStack {
        Text("평점")
        Text("평점")
      }
      VStack {
        Text("책 정보")
        Text("예리하고..")
      }
      VStack {
        Text("게시일")
        Text("예리하고..")
      }
      }
    }
    .padding()
  }
}
