//
//  NavigationLink+.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI

extension View {
  func navigatePush<Destination: View>(
    to: Destination,
    isActive toggle: Binding<Bool>
  ) -> some View {
    NavigationLink(
      destination: to,
      isActive: toggle
    ) { self }
  }
}
