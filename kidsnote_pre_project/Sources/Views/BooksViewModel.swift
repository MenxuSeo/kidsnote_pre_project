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
  @Published var isLoading = false
  
  private let apiClient = APIClient()
  private var cancellables = Set<AnyCancellable>()
  
  private let size = 10
  private var page = 0
  private var totalPages = 0
  
  
  init() {
    $searchText
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .sink { [weak self] text in
        self?.requestBooks(query: text)
      }
      .store(in: &cancellables)
  }
  
  func requestLoadMoreBooks() {
    guard !isLoading else { return }
    requestMoreBooks(query: searchText)
  }
  
  func requestMoreBooks(query: String) {
    guard !isLoading else { return }
    isLoading = true
    
    apiClient.books(query: query, page: page, size: size)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        self?.isLoading = false
        guard case .finished = completion else { return }

        print("completion: \(completion)")
      }, receiveValue: { books in
        print("books: \(books)")
        self.books.append(contentsOf: books.map { $0.toDomain() })
        self.page += 1
      })
      .store(in: &cancellables)
  }
  
  func requestBooks(query: String) {
    books = []
    page = 0
    
    guard query.isNotEmpty else { return }
    
    requestMoreBooks(query: query)
  }
}
