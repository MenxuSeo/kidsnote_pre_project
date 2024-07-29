//
//  ImageCache.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import Combine
import SwiftUI

class ImageCache {
  static let shared = ImageCache()
  private var cache: [String: Image] = [:]
  
  private init() {}
  
  func getImage(forKey key: String?) -> Image? {
    guard let key = key else { return nil }
    return cache[key]
  }
  
  func setImage(_ image: Image, forKey key: String) {
    cache[key] = image
  }
}

class ImageLoader: ObservableObject {
  @Published var image: Image?
  private var url: URL?
  private var cancellable: AnyCancellable?
  
  init(url: URL?) {
    self.url = url
  }
  
  func load() {
    guard let url = url else { return }
    
    if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
      self.image = cachedImage
    } else {
      cancellable = URLSession.shared.dataTaskPublisher(for: url)
        .map { Image(data: $0.data) }
        .replaceError(with: nil)
        .handleEvents(
          receiveOutput: { [weak self] image in
            guard let self = self, let image = image else { return }
            ImageCache.shared.setImage(image, forKey: url.absoluteString)
          }
        )
        .receive(on: DispatchQueue.main)
        .assign(to: \.image, on: self)
    }
  }
  
  func cancel() {
    cancellable?.cancel()
  }
}
