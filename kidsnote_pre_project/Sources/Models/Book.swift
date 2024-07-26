//
//  Book.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Foundation

struct Book: Identifiable, Codable {
  let id: String
  let kind: String?
  let selfLink: String?
  let volumeInfo: Volume?
  let etag: String?
//  let accessInfo
//  let searchInfo
//  let saleInfo
}


struct BooksResponse: Codable {
  let items: [Book]
  let totalItems: Int?
  let kind: String?
}
