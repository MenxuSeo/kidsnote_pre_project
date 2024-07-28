//
//  Book.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Foundation

struct Book: Identifiable, Codable {
  let id: String?
  let volumeInfo: VolumeInfo?
  
  var title: String? { volumeInfo?.title }
  var authors: [String]? { volumeInfo?.authors }
  var description: String? { volumeInfo?.description }
  var thumbnail: URL? { URL(string: volumeInfo?.imageLinks?.thumbnail ?? "") }
  
  enum CodingKeys: String, CodingKey {
    case id
    case volumeInfo
//    case title = "volumeInfo.title"
//    case authors = "volumeInfo.authors"
//    case description = "volumeInfo.description"
//    case thumbnail = "volumeInfo.imageLinks.thumbnail"
  }
}


struct BooksResponse: Codable {
  let items: [Book]
  let totalItems: Int?
  let kind: String?
}
