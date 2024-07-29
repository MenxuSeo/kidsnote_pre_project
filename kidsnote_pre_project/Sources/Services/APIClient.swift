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
  
  func books(
    query: String,
    page _page: Int,
    size _size: Int
  ) -> AnyPublisher<[BookResponse], APIError> {
    guard var urlComponents = URLComponents(string: baseURL) else {
      return Fail(error: APIError.urlError).eraseToAnyPublisher()
    }
    
    let page = max(0, _page)
    let size = min(40, max(10, _size))
    
    urlComponents.queryItems = [
      URLQueryItem(name: "q", value: query),
      URLQueryItem(name: "startIndex", value: "\(page * size)"),
      URLQueryItem(name: "key", value: apiKey),
    ]
    
    guard let url = urlComponents.url else {
      return Fail(error: APIError.queryError).eraseToAnyPublisher()
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
  
  func book(id: String) -> AnyPublisher<BookResponse, APIError> {
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

