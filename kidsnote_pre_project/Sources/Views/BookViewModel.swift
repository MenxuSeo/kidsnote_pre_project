//
//  BookViewModel.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import Combine
import Foundation

class BookViewModel: ObservableObject {
  @Published var book: Book
  
  private let apiClient = APIClient()
  private var cancellables = Set<AnyCancellable>()
  
  init(book: Book) {
    self.book = book
  }
  
  func requestBook() {
    apiClient.book(id: book.id)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        guard case .finished = completion else { return }
      }, receiveValue: { bookDetail in
        guard let _ = bookDetail.id else { return }
        print(bookDetail.toDomain())
        self.book = bookDetail.toDomain()
        
      })
      .store(in: &cancellables)
  }
}
