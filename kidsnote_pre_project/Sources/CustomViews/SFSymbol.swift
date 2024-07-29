//
//  SFSymbol.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

enum SFSymbolType: String {
  case share = "square.and.arrow.up"
  case more = "chevron.right"
  case x = "xmark"
}

struct SFSymbol: View {
  var type: SFSymbolType
  
  var body: some View {
    Image(systemName: type.rawValue)
  }
}
