//
//  BooksViewModel.swift
//  kidsnote_pre_project
//
//  Created by seo on 26/7/24.
//

import Combine
import Foundation

class BooksViewModel: ObservableObject {
  @Published var books: [Book] = []
  
  private let apiClient = APIClient()
  private var cancellables = Set<AnyCancellable>()
  
  func searchBooks(query: String) {
    apiClient.searchBooks(query: query)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        guard case .finished = completion else { return }

        print("completion: \(completion)")
      }, receiveValue: { books in
        print("books: \(books)")
        self.books = books
//        dump(self.books)
      })
      .store(in: &cancellables)
  }
}
