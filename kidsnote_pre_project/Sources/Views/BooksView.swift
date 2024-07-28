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
    NavigationStack {
      List(viewModel.books) { book in
        NavigationLink(destination: BookView(book: book)) {
          HStack {
            CachedAsyncImage(url: book.thumbnail)
              .frame(width: 50, height: 70)
            VStack(alignment: .leading) {
              Text(book.title ?? "")
              Text((book.authors?.joined(separator: ", ")) ?? "")
              Text("eBook")
            }
          }
        }
      }
    }
    .onAppear {
      viewModel.searchBooks(query: searchText)
      print("viewModel.books: \(viewModel.books.count)")
    }
    .searchable(text: $searchText)
  }
}

#Preview {
  BooksView(searchText: "아이폰")
}
