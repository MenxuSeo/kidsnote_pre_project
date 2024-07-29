//
//  Date+.swift
//  kidsnote_pre_project
//
//  Created by seo on 28/7/24.
//

import Foundation

extension DateFormatter {
  static let jsonDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
  
  static let localizedDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale.current
    return formatter
  }()
}
