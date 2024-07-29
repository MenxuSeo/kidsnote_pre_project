//
//  BookView.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

struct BookView: View {
  @State private var isShareSheetPresented = false
  @State private var isWebViewSheetPresented = false
  let book: Book
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        HStack(alignment: .top, spacing: 20) {
          ImageCache.shared.getImage(forKey: book.thumbnail?.absoluteString)?
            .resizable()
            .frame(width: 100, height: 130)
          VStack(alignment: .leading) {
            Text(book.title ?? "")
              .lineLimit(2)
              .minimumScaleFactor(0.4)
            Text(book.authors?.joined(separator: ", ") ?? "")
            Text("eBook - \(book.volumeInfo?.pageCount ?? 0)페이지")
          }
        }
        Divider()
        HStack {
          KNButton("읽음", filledStyle: .empty) {
            isWebViewSheetPresented = true
          }
          KNButton("위시리스트에 추가", filledStyle: .filled) {
            
          }
        }
        Text("Google Play 웹사이트에서 구매한 책을 이 앱에서 읽을 수 있습니다.")
          .lineLimit(1)
          .minimumScaleFactor(0.1)
        Divider()
        Paragraph<Text>(
          "eBook 정보",
          bodyText: book.volumeInfo?.description,
          rightSymbol: .more
        )
        Paragraph(
          "평점 및 리뷰",
          rightSymbol: .more
        ) {
          HStack {
            VStack(alignment: .leading) {
              Text("3.7")
              Text("*****")
            }
          }
        }
        Paragraph<Text>("게시일", bodyText: "\(book.publishedDate ?? "") - \(book.volumeInfo?.publisher ?? "")")
      }
      .background(Color.red)
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
      WebView(webView: .init(url: book.volumeInfo?.previewLink.toURL)) {}
    }
    .sheet(isPresented: $isShareSheetPresented) {
      let bookLink = book.volumeInfo?.infoLink ?? "books.google.com"
      return ShareSheet(items: ["공유하기", URL(string: bookLink)!])
    }
  }
}

//#Preview {
//  BookView()
//}
