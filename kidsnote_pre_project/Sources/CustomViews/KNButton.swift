//
//  KNButton.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

struct KNButton: View {
  enum FilledStyle {
    case empty
    case filled
  }
  
  private let title: String
  private let filledStyle: FilledStyle
  private let action: () -> Void
  
  private let foregroundColor: Color
  private let backgroundColor: Color
  private let borderColor: Color = .blue
  
  init(
    _ title: String,
    filledStyle: FilledStyle = .empty,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.filledStyle = filledStyle
    self.action = action
    
    if filledStyle == .empty {
      foregroundColor = Color.blue
      backgroundColor = Color.white
    } else {
      foregroundColor = Color.white
      backgroundColor = Color.blue
    }
  }
  
  var body: some View {
    Button {
      action()
    } label: {
      ZStack {
        backgroundColor
        Text(title)
          .font(.footnote)
          .foregroundStyle(foregroundColor)
          .padding(.vertical, 10)
          .padding(.horizontal, 16)
          .lineLimit(1)
          .minimumScaleFactor(0.1)
      }
      .frame(maxWidth: .infinity)
      .cornerRadius(4)
      .overlay(
        RoundedRectangle(cornerRadius: 4)
          .stroke(borderColor, lineWidth: 1)
      )
    }
  }
}
