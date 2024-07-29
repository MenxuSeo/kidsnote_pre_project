//
//  String+.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import Foundation

extension String {
  var isNotEmpty: Bool { !isEmpty }
  var toURL: URL? { URL(string: self)}
}

extension Optional where Wrapped == String {
  var toURL: URL? {
    guard let string = self else { return URL(string: "books.google.com") }
    return URL(string: string)
  }
}
