//
//  APIError.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Foundation

enum APIError: Error {
  case decodingError
  case urlError
  case httpError(Int)
  case unknown
}
