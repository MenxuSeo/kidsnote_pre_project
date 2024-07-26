//
//  Volume.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Foundation

struct Volume: Codable {
  let title: String?
  let authors: [String]?
  let publisher: String?
  let description: String?
  //  let readingModes:
  let pageCount: Int?
  let printType: String?
  let categories: [String]?
  let maturityRating: String?
  let allowAnonLogging: Bool?
  let contentVersion: String?
//  let panelizationSummary
//  let imageLinks
  let language: String?
  let previewLink: String?
  let infoLink: String?
  let canonicalVolumeLink: String?
}
