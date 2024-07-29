//
//  BooksView.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import SwiftUI



struct BooksView: View {
  private enum FocusField: Hashable {
    case searchBar
  }
  
  @ObservedObject var viewModel = BooksViewModel()
  @State var selectedBookType: BookType = .eBook
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    ZStack {
      NavigationStack {
        VStack(spacing: 14) {
          SearchBar(text: $viewModel.searchText)
            .focused($focusedField, equals: .searchBar)
          Divider()
            .onAppear {
              focusedField = .searchBar
            }
          if viewModel.searchText.isNotEmpty {
            VStack(alignment: .leading, spacing: 2) {
              KNPicker(selectedBookType: $selectedBookType)
              Divider()
              Text("Google Play 검색결과")
                .font(.title2)
                .padding(.top, 16)
            }
          }
          
          if selectedBookType == .eBook {
            ebookView
          } else {
            Spacer()
            Text("🛠️ 공사중")
            Spacer()
          }
        }
        
      }
      if viewModel.isLoading {
        ProgressView()
          .frame(alignment: .center)
          .padding(40)
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
                .foregroundStyle(Color.secondary)
              Text("eBook")
                .font(.caption)
                .foregroundStyle(Color.secondary)
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
