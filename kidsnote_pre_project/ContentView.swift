//
//  ContentView.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    ZStack {
      BooksView()
    }
    
  }
}
