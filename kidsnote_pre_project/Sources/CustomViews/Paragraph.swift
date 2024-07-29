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
  var rightSFSymbol: SFSymbolType?
  var bodyView: (() -> V)?
  var destination: (() -> V)?
  
  @State var isActive = false
  
  init(
    _ title: String?,
    bodyText: String? = nil,
    rightSymbol: SFSymbolType? = nil,
    bodyView: (() -> V)? = nil,
    destination: (() -> V)? = nil
  ) {
    self.title = title ?? ""
    self.bodyText = bodyText
    self.rightSFSymbol = rightSymbol
    self.bodyView = bodyView
    self.destination = destination
  }
  
  var body: some View {
    Button(action: {
      if destination != nil {
        isActive = true
      }
    }, label: {
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Text(title)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
          
          Spacer()
          
          if let rightSymbol = rightSFSymbol {
            SFSymbol(type: rightSymbol)
              .foregroundColor(.blue)
          }
        }
        
        if let bodyText = bodyText {
          Text(bodyText)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            .foregroundColor(.gray)
            .lineLimit(4)
        }
        
        if let bodyView = bodyView {
          bodyView()
        }
      }
//      .padding()
      .background(
        NavigationLink(destination: destinationView, isActive: $isActive) {}
  //      .opacity(destination == nil ? 0 : 1)
      )
    })
    .foregroundColor(.black)
  }
  
  @ViewBuilder
  private var destinationView: some View {
    if let destination = destination {
      destination()
    } else {
      EmptyView()
    }
  }
}

#Preview {
  Paragraph("Title", bodyText: "Description text here", rightSymbol: .more) {
    Text("Body View Content")
  } destination: {
    Text("Destination View")
  }
}
