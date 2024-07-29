//
//  Book.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Foundation

struct Book: Codable, Identifiable, Equatable {
  let id: String
  let title: String
  let thumbnail: URL?
  let authors: [String]
  let publisher: String
  let publishedDate: String
  let description: String
  let page: Int
  let isEbook: Bool
  let averageRating: Double
  let ratingsCount: Int
  let infoLink: String
  
  static func ==(lhs: Book, rhs: Book) -> Bool {
    return lhs.id == rhs.id
  }
}


struct BooksResponse: Codable {
  let items: [BookResponse]
  let totalItems: Int?
  let kind: String?
}

struct BookResponse: Codable {
  let kind: String?
  let id: String?
  let etag: String?
  let selfLink: String?
  let volumeInfo: VolumeInfo?
  let saleInfo: SaleInfo?
  let accessInfo: AccessInfo?
  
  enum CodingKeys: String, CodingKey {
    case id
    case kind
    case etag
    case selfLink
    case volumeInfo
    case saleInfo
    case accessInfo
  }
  
  struct SaleInfo: Codable {
    let country: String?
    let saleability: String?
    let isEbook: Bool?
    let listPrice: Price?
    let retailPrice: Price?
    let buyLink: String?
    
    struct Price: Codable {
      let amount: Double?
      let currencyCode: String?
    }
  }
  
  struct AccessInfo: Codable {
    let country: String
    let viewability: String
    let embeddable: Bool
    let publicDomain: Bool
    let textToSpeechPermission: String
    let epub: Format
    let pdf: Format
    let accessViewStatus: String
    
    struct Format: Codable {
      let isAvailable: Bool
      let acsTokenLink: String?
    }
  }
}

extension BookResponse {
  func toDomain() -> Book {
    return Book(
      id: id ?? "",
      title: volumeInfo?.title ?? "",
      thumbnail: volumeInfo?.imageLinks?.thumbnail?.toURL,
      authors: volumeInfo?.authors ?? [],
      publisher: volumeInfo?.publisher ?? "",
      publishedDate: volumeInfo?.publishedDate ?? "",
      description: volumeInfo?.description ?? "",
      page: volumeInfo?.pageCount ?? 0,
      isEbook: saleInfo?.isEbook ?? false,
      averageRating: volumeInfo?.averageRating ?? -1,
      ratingsCount: volumeInfo?.ratingsCount ?? -1,
      infoLink: volumeInfo?.infoLink ?? ""
    )
  }
  
  private func localizedDateFormatter(dateString: String?) -> String {
    guard let dateStr = dateString,
          let date = DateFormatter.jsonDateFormatter.date(from: dateStr) else { return "" }
    return DateFormatter.localizedDateFormatter.string(from: date)
  }
}
