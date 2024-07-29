//
//  BooksViewModel.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Combine
import Foundation

class BooksViewModel: ObservableObject {
  @Published var searchText: String = ""
  @Published var books: [Book] = []
  
  private let apiClient = APIClient()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $searchText
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .sink { [weak self] text in
        self?.searchBooks(query: text)
      }
      .store(in: &cancellables)
  }
  
  func searchBooks(query: String) {
    guard query.isNotEmpty else {
      self.books = []
      return
    }
    
    apiClient.searchBooks(query: query)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        guard case .finished = completion else { return }

        print("completion: \(completion)")
      }, receiveValue: { books in
        print("books: \(books)")
        self.books = books.map { $0.toDomain() }
//        dump(self.books)
      })
      .store(in: &cancellables)
  }
}
