//
//  Volume.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Foundation

struct IndustryIdentifier: Codable {
  let type: String?
  let identifier: String?
}

struct VolumeInfo: Codable {
  let title: String
  let authors: [String]?
  let publisher: String?
  let publishedDate: String?
  let description: String?
  let industryIdentifiers: [IndustryIdentifier]?
  let pageCount: Int?
  let dimensions: Dimensions?
  let printType: String?
  let mainCategory: String?
  let categories: [String]?
  let averageRating: Double?
  let ratingsCount: Int?
  let contentVersion: String?
  let imageLinks: ImageLinks?
  let language: String?
  let infoLink: String?
  let canonicalVolumeLink: String?
}

struct Dimensions: Codable {
  let height: String?
  let width: String?
  let thickness: String?
}

struct ImageLinks: Codable {
  let smallThumbnail: String?
  let thumbnail: String?
  let small: String?
  let medium: String?
  let large: String?
  let extraLarge: String?
}

struct SaleInfo: Codable {
  let country: String?
  let saleability: String?
  let isEbook: Bool?
  let listPrice: Price?
  let retailPrice: Price?
  let buyLink: String?
}

struct Price: Codable {
  let amount: Double?
  let currencyCode: String?
}

struct AccessInfo: Codable {
  let country: String?
  let viewability: String?
  let embeddable: Bool?
  let publicDomain: Bool?
  let textToSpeechPermission: String?
  let epub: Epub?
  let pdf: PDF
  let accessViewStatus: String?
}

struct Epub: Codable {
  let isAvailable: Bool?
  let acsTokenLink: String?
}

struct PDF: Codable {
  let isAvailable: Bool?
}
