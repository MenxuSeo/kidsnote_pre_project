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
  
  func searchBooks(query: String) -> AnyPublisher<[BookResponse], APIError> {
    guard let url = URL(string: "\(baseURL)?q=\(query)&key=\(apiKey)") else {
      return Fail(error: APIError.urlError).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: BooksResponse.self, decoder: JSONDecoder())
      .map { $0.items }
      .mapError { error in
        switch error {
        case is URLError:
          return .urlError
        case is DecodingError:
          return .decodingError
        case let httpError as APIError:
          return httpError
        default:
          return .unknown
        }
      }
      .eraseToAnyPublisher()
  }
  
  func searchBook(id: String) -> AnyPublisher<BookResponse, APIError> {
    guard let url = URL(string: "\(baseURL)/\(id)?key=\(apiKey)") else {
      return Fail(error: APIError.urlError).eraseToAnyPublisher()
    }
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: BookResponse.self, decoder: JSONDecoder())
      .mapError { error in
        switch error {
        case is URLError:
          return .urlError
        case is DecodingError:
          return .decodingError
        case let httpError as APIError:
          return httpError
        default:
          return .unknown
        }
      }
      .eraseToAnyPublisher()
  }
}

