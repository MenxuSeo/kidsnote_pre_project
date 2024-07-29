//
//  WishlistViewModel.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import Combine
import SwiftUI

class WishlistViewModel: ObservableObject {
  @Published var items: [Book] = []
  @Published var isInWishlist: Bool = false
  
  private let key = "wishlist"
  private let userDefaults = UserDefaults.standard
  
  init() {
    loadItems()
  }
  
  func addItem(_ item: Book) {
    items.append(item)
    saveItems()
  }
  
  func removeItem(_ item: Book) {
    items.removeAll { $0.id == item.id }
    saveItems()
  }
  
  func checkItem(_ item: Book) -> Bool {
    let res = items.contains { $0.id == item.id }
    isInWishlist = res
    return res
  }
  
  private func saveItems() {
    guard let data = try? JSONEncoder().encode(items) else { return }
    userDefaults.set(data, forKey: key)
  }
  
  private func loadItems() {
    guard let data = userDefaults.data(forKey: key),
          let savedItems = try? JSONDecoder().decode([Book].self, from: data) else {
//      items = []
      return
    }
    items = savedItems
  }
}
