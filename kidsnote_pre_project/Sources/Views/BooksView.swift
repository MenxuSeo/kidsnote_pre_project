//
//  BooksView.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import SwiftUI

struct BooksView: View {
  @ObservedObject var viewModel = BooksViewModel()
  
  @State var searchText: String = "1"
  var body: some View {
    List(viewModel.books) { book in
      HStack {
        if let thumbnail = book.thumbnail {
          AsyncImage(url: thumbnail) { image in
            image.resizable()
          } placeholder: {
            ProgressView()
          }
          .frame(width: 30, height: 70)
        }
        VStack(alignment: .leading) {
          Text(book.title ?? "")
          Text((book.authors?.joined(separator: ", ")) ?? "")
          Text("eBook")
        }
        
      }
    }
    .background(Color.blue)
    .onTapGesture {
      viewModel.searchBooks(query: searchText)
      print("viewModel.books: \(viewModel.books.count)")
    }
    .searchable(text: $searchText)
  }
}

#Preview {
  BooksView(searchText: "아이폰")
}
