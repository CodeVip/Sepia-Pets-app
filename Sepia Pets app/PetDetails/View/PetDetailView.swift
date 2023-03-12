//
//  PetDetailView.swift
//  Sepia Pets app
//
//  Created by vipin on 3/11/23.
//

import SwiftUI
import WebKit

struct PetDetailView: View {
    var pet:Pet
    var body: some View {
     WebView(url: pet.contentURL)
    }
}
struct WebView : UIViewRepresentable {
    @State var url: String // 1
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView(frame: .zero) // 2
        webView.load(URLRequest(url: URL(string: url)!))
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {} // 4
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let exceptions = SecTrustCopyExceptions(serverTrust)
        SecTrustSetExceptions(serverTrust, exceptions)
        completionHandler(.useCredential, URLCredential(trust: serverTrust));
    }
}

