//
//  TextIcon.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

struct TextIcon: ViewModifier {
  var icon: SFSymbol
  var side: Side
  
  enum Side {
    case leading
    case trailing
  }
  
  func body(content: Content) -> some View {
    HStack {
      if side == .leading {
        icon
        content
      } else {
        content
        icon
      }
    }
  }
}

extension View {
  func textIcon(icon: SFSymbolType, side: TextIcon.Side) -> some View {
    modifier(
      TextIcon(icon: SFSymbol(type: icon), side: side)
    )
  }
}
