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
  var rightSFSymbol: SFSymbolType?
  
  init(
    _ title: String?,
    bodyText: String? = nil,
    rightSymbol: SFSymbolType? = nil,
    bodyView: (() -> V)? = nil
  ) {
    self.title = title ?? ""
    self.bodyText = bodyText
    self.rightSFSymbol = rightSymbol
    self.bodyView = bodyView
  }
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Text(title)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.title)
        Spacer()
        if let rightSymbol = rightSFSymbol {
          SFSymbol(type: rightSymbol)
            .foregroundColor(.blue)
        }
      }
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

#Preview {
  Paragraph("title", bodyText: "국내 최대의...") {
    EmptyView()
  }
}
