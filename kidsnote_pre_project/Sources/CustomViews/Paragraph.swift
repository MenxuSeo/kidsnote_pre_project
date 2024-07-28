//
//  Paragraph.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

struct Paragraph<V: View>: View {
  var title: String
  var bodyText: String?
  var bodyView: (() -> V)?

  
  init(
    _ title: String?,
    bodyText: String? = nil,
    bodyView: (() -> V)? = nil
  ) {
    self.title = title ?? ""
    self.bodyText = bodyText
    self.bodyView = bodyView
  }
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.title)
      if let bodyText = bodyText {
        Text(bodyText)
          .font(.subheadline)
      }
      if let bodyView = bodyView {
        bodyView()
      }
    }
    
    
  }
}
