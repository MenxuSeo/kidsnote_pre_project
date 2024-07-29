//
//  BookDetailView.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

struct BookDetailView: View {
  var book: Book
  
  var body: some View {
    WebView(webView: .init(htmlString: book.htmlDescription), webViewType: .navigation) {}
      .navigationTitle(book.title)
  }
}
