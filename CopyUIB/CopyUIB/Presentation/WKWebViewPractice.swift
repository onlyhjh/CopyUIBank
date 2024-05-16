//
//  WKWebViewPractice.swift
//  CopyUIBank
//
//  Created by 60192229 on 5/13/24.
//

import SwiftUI
import WebKit
import Combine


struct WKWebViewPractice: UIViewRepresentable {
    let webView = WKWebView()
    let urlStr: String
    
    func makeUIView(context: Context) -> WKWebView {
        print("urlStr: \(urlStr)")
        if let url = URL(string: urlStr) {
            webView.load(URLRequest(url: url))    // 지정된 URL 요청 개체에서 참조하는 웹 콘텐츠를로드하고 탐색
        }
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WKWebViewPractice>) {
        if let url = URL(string: urlStr) {
            webView.load(URLRequest(url: url))
        }
    }
    
    func reLoad() {
        if let url = URL(string: urlStr) {
            webView.load(URLRequest(url: url))
        }
    }
}
