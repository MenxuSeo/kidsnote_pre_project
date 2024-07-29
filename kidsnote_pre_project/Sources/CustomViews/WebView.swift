//
//  WebView.swift
//  kidsnote_pre_project
//
//  Created by seo on 29/7/24.
//

import SwiftUI
import WebKit

struct WebView<Content> where Content: View  {
  
  enum WebViewType {
    case navigation
    case sheet
  }
  
  @Environment(\.dismiss) private var dismiss
  @State private var isLoading = false
  
  var title: String
  var webViewType: WebViewType
  var webView: WebViewController
  var content: Content
  
  init(
    _ title: String = "",
    webView: WebViewController,
    webViewType: WebViewType = .sheet,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self.webView = webView
    self.webViewType = webViewType
    self.content = content()
  }
}

extension WebView: View {
  var body: some View {
    ZStack {
      NavigationView {
        if webViewType == .sheet {
          bodyView
            .navigationBarItems(
              leading:
                SFSymbol(type: .x)
                .onTapGesture {
                  dismiss()
                }
            )
          
        } else {
          bodyView
        }
      }
    }
  }
  
  var bodyView: some View {
    VStack {
      webView
        .padding(16)
      content
    }
    .navigationTitle(title)
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    
  }
}


struct WebViewController: UIViewRepresentable {
  @Environment(\.colorScheme) var colorScheme
  
  var url: URL?
  var htmlString: String?
  
  @State var isLoading = true
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> WKWebView {
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
    } else if let htmlString = htmlString {
      webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    webView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    return webView
  }
  
  func updateUIView(_ webView: WKWebView, context: Context) {
    setBackgroundColor(webView: webView, colorScheme: colorScheme)
  }
  
  private func setBackgroundColor(webView: WKWebView, colorScheme: ColorScheme) {
    let backgroundColor = colorScheme == .dark ? "black" : "white"
    let textColor = colorScheme == .dark ? "white" : "black"
    
    let jsString = """
          document.body.style.backgroundColor = '\(backgroundColor)';
          document.body.style.color = '\(textColor)';
          """
    
    webView.evaluateJavaScript(jsString, completionHandler: nil)
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
      parent.setBackgroundColor(webView: webview, colorScheme: parent.colorScheme)

    }
  }
}

