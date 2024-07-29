//
//  RoundedCorner.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}

extension View {
  public func topRadius<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
    let roundedRect = RoundedCorner(radius: cornerRadius, corners: [.topLeft, .topRight])
    return clipShape(roundedRect)
      .overlay(roundedRect.stroke(content, lineWidth: width))
  }
}
