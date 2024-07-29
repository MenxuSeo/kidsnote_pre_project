//
//  ShareSheet.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
  var items: [Any]
  var excludedActivityTypes: [UIActivity.ActivityType]? = nil
  
  func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
    controller.excludedActivityTypes = excludedActivityTypes
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
