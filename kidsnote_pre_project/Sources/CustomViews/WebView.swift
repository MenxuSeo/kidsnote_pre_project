//
//  WebView.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI
import WebKit

struct WebView<Content> where Content: View  {
  @Environment(\.dismiss) private var dismiss
  @State private var isLoading = false
  
  var title: String
  var webView: WebViewController
  var content: Content
  
  init(
    _ title: String = "",
    webView: WebViewController,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self.webView = webView
    self.content = content()
  }
}

extension WebView: View {
  var backButton: some View {
    Button(action: {
      dismiss()
    }) {
      Image(systemName: "chevron.backward")
    }
  }
  var body: some View {
    ZStack {
      NavigationView {
        VStack {
          webView
            .padding(16)
          content
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(
          leading:
            SFSymbol(type: .x)
            .onTapGesture {
              dismiss()
            })
      }
    }
  }
}


struct WebViewController: UIViewRepresentable {
  var url: URL?
  @State var isLoading = true
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  /// 뷰 초기화
  func makeUIView(context: Context) -> some UIView {
    let preferences = WKPreferences()
    preferences.javaScriptCanOpenWindowsAutomatically = false
    
    let configuration = WKWebViewConfiguration()
    configuration.preferences = preferences
    
    let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
    webView.navigationDelegate = context.coordinator
    webView.allowsBackForwardNavigationGestures = true
    webView.scrollView.isScrollEnabled = true
    
    if let url = url {
      webView.load(URLRequest(url: url))
    }
    
    webView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    return webView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
  
  class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebViewController
    
    init(_ uiWebView: WebViewController) {
      self.parent = uiWebView
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      parent.isLoading = true
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
      parent.isLoading = false
    }
    
    func webView(_ webview: WKWebView, didFinish: WKNavigation!) {
      parent.isLoading = false
    }
  }
}

