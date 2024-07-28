//
//  APIClient.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Combine
import Foundation

final class APIClient {
  private let baseURL = "https://www.googleapis.com/books/v1/volumes"
  private let apiKey = ""
  
  func searchBooks(query: String) -> AnyPublisher<[Book], Error> {
    guard let url = URL(string: "\(baseURL)?q=\(query)&key=\(apiKey)") else {
      return Fail(error: APIError.urlError).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: BooksResponse.self, decoder: JSONDecoder())
      .map { $0.items }
      .eraseToAnyPublisher()
  }
}

