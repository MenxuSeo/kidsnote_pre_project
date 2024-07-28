//
//  BooksView.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import SwiftUI

struct BooksView: View {
  enum BookType: String, CaseIterable {
    case eBook
    case 오디오북
  }
  @ObservedObject var viewModel = BooksViewModel()
  @State var selectedBookType: BookType = .eBook
  
  var body: some View {
    NavigationStack {
      Picker("ㅒㅔ샤ㅐㅜㄴ", selection: $selectedBookType) {
        ForEach(BookType.allCases, id: \.self) { bookType in
          Text(bookType.rawValue)
        }
      }
      .pickerStyle(.segmented)
      .padding(.horizontal)
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
      .listStyle(.plain)
    }
    .onAppear {
      viewModel.searchBooks(query: viewModel.searchText)
      print("viewModel.books: \(viewModel.books.count)")
    }
    .searchable(text: $viewModel.searchText)
  }
}

#Preview {
  BooksView()
}
