//
//  BookView.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

struct BookView: View {
  @StateObject private var wishlistViewModel = WishlistViewModel()
  @ObservedObject var viewModel: BookViewModel
  
  @State private var isShareSheetPresented = false
  @State private var isWebViewSheetPresented = false
  
  init(_ book: Book) {
    viewModel = BookViewModel(book: book)
  }
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        bookInfo
        Divider()
        actionButtons
        Text("Google Play 웹사이트에서 구매한 책을 이 앱에서 읽을 수 있습니다.")
          .lineLimit(1)
          .minimumScaleFactor(0.1)
        Divider()
        Paragraph<Text>(
          "eBook 정보",
          bodyText: viewModel.book.description,
          rightSymbol: .more
        )
        if viewModel.book.averageRating > 0 {
          Paragraph(
            "평점 및 리뷰",
            rightSymbol: .more
          ) {
            HStack {
              VStack(alignment: .leading) {
                Text("\(viewModel.book.ratingsCount)")
                Text("*****")
              }
            }
          }
        }
        Paragraph<Text>("게시일", bodyText: "\(viewModel.book.publishedDate) - \(viewModel.book.publisher)")
      }
    }
    .onAppear {
      viewModel.requestBook()
    }
    .padding()
    .toolbar {
      ToolbarItem {
        SFSymbol(type: .share)
          .foregroundColor(.blue)
          .onTapGesture {
            isShareSheetPresented = true
          }
      }
    }
    .fullScreenCover(isPresented: $isWebViewSheetPresented) {
      WebView(webView: .init(url: viewModel.book.infoLink.toURL)) {}
    }
    .sheet(isPresented: $isShareSheetPresented) {
      let bookLink = viewModel.book.infoLink ?? "books.google.com"
      return ShareSheet(items: ["공유하기", URL(string: bookLink)!])
    }
    .frame(maxWidth: .infinity, alignment: .topLeading)
    .navigationBarTitleDisplayMode(.inline)
  }
  
  var bookInfo: some View {
    HStack(alignment: .top, spacing: 20) {
      CachedAsyncImage(url: viewModel.book.thumbnail)
        .frame(width: 100, height: 130)
      VStack(alignment: .leading) {
        Text(viewModel.book.title)
          .font(.title2)
          .lineLimit(2)
          .minimumScaleFactor(0.4)
        Text(viewModel.book.authors.joined(separator: ", "))
          .font(.subheadline)
          .foregroundStyle(Color.gray)
        Text("\(viewModel.book.isEbook ? "eBook" : "오디오북") - \(viewModel.book.page)페이지")
          .foregroundStyle(Color.gray)
      }
    }
  }
  
  var actionButtons: some View {
    HStack {
      KNButton("읽음", filledStyle: .empty) {
        isWebViewSheetPresented = true
      }
      if wishlistViewModel.isInWishlist {
        KNButton("위시리스트에서 삭제", filledStyle: .filled) {
          wishlistViewModel.removeItem(viewModel.book)
          wishlistViewModel.checkItem(viewModel.book)
          
        }
      } else {
        KNButton("위시리스트에 추가", filledStyle: .filled) {
          wishlistViewModel.addItem(viewModel.book)
          wishlistViewModel.checkItem(viewModel.book)
        }
      }
      
    }
    .onAppear {
      wishlistViewModel.checkItem(viewModel.book)
      print()
    }
  }
}

//#Preview {
//  BookView()
//}
