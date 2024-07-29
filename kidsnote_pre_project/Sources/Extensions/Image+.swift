//
//  Image+.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import SwiftUI

extension Image {  
  init?(data: Data) {
    guard let image = UIImage(data: data) else { return nil }
    self = .init(uiImage: image)
  }
  
}
