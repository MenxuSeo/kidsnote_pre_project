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
      Picker("segmented", selection: $selectedBookType) {
        ForEach(BookType.allCases, id: \.self) { bookType in
          Text(bookType.rawValue)
        }
      }
      .pickerStyle(.segmented)
      .padding(.horizontal)
      .searchable(text: $viewModel.searchText)
      
      VStack {
        if selectedBookType == .eBook {
          ebookView
        } else {
          Spacer()
          Text("🛠️ 공사중")
          Spacer()
        }
        
      }
    }
  }
  
  var ebookView: some View {
    VStack(alignment: .leading) {
      List(viewModel.books) { book in
        ZStack {
          NavigationLink(destination: BookView(book)) {}
          .opacity(0)
          HStack(alignment: .top, spacing: 16) {
            CachedAsyncImage(url: book.thumbnail)
              .frame(width: 100, height: 140)
              .cornerRadius(8)
              .shadow(radius: 8)
            VStack(alignment: .leading) {
              Text(book.title)
                .font(.subheadline)
                .lineLimit(2)
              Text((book.authors.joined(separator: ", ")))
                .font(.caption)
                .foregroundStyle(Color.gray)
              Text("eBook")
                .font(.caption)
                .foregroundStyle(Color.gray)
            }
            .lineLimit(1)
            .onAppear {
              if book == viewModel.books.last {
                viewModel.requestLoadMoreBooks()
              }
            }
            Spacer()
          }
        }
        .listRowSeparator(.hidden)
      }
      
      .listStyle(.plain)
      .padding(0)
      if viewModel.isLoading {
        ProgressView()
      }
    }
  }
    
}

#Preview {
  BooksView()
}
