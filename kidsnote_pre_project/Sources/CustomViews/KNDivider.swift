//
//  KNDivider.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

extension Rectangle {
  func lineDivider() -> some View {
    self
      .fill(Color.secondary)
      .frame(height: 1)
      .padding(.horizontal, 20)
      .padding(.top, 2)
      .padding(.bottom, 10)
  }
  
  func paddingDivider(color: Color = Color.secondary) -> some View {
    VStack {
      self
        .fill(color)
        .padding(.vertical, 19)
    }
    .frame(maxHeight: 48)
  }
}

struct KNDivider: View {
  private let color: Color
  private let width: CGFloat
  private let height: CGFloat
  
  init(color: Color = Color.secondary, width: CGFloat = .infinity, height: CGFloat = 1) {
    self.color = color
    self.width = width
    self.height = height
  }
  
  var body: some View {
    Rectangle()
      .fill(color)
      .frame(maxWidth: width)
      .frame(height: height)
  }
}
