//
//  CachedAsyncImage.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

struct CachedAsyncImage: View {
  @StateObject private var loader: ImageLoader
  
  init(url: URL?) {
    _loader = StateObject(wrappedValue: ImageLoader(url: url))
  }
  
  var body: some View {
    content
      .onAppear { loader.load() }
      .onDisappear { loader.cancel() }
  }
  
  private var content: some View {
    Group {
      if let image = loader.image {
        image.resizable()
      } else {
        ProgressView()
      }
    }
  }
}
