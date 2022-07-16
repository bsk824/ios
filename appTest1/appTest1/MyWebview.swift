////
////  MyWebview.swift
////  appTest1
////
////  Created by 백승기 on 2022/02/18.
////
//
//import SwiftUI
//import WebKit
//
//struct MyWebview: UIViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    
//    var htmlFileName: String
//    
//    @ObservedObject var webViewStateModel: WebViewStateModel
//    
//    typealias UIViewType = WKWebView
// 
//    class Coordinator: NSObject,WKNavigationDelegate {
//        let parent: MyWebview
//        init(_ parent: MyWebview) {
//            self.parent = parent
//        }
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            if parent.webViewStateModel.goBack {
//                webView.goBack()
//                parent.webViewStateModel.goBack = false
//            }
//            if parent.webViewStateModel.goForward {
//                webView.goForward()
//                parent.webViewStateModel.goForward = false
//            }
//        }
//    }
//    
//    func makeUIView(context: Context) -> WKWebView {
//        let view = WKWebView(frame: CGRect.zero)
//        view.navigationDelegate = context.coordinator
//        view.allowsBackForwardNavigationGestures = true
//        view.scrollView.isScrollEnabled = true
//        return view
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.load(htmlFileName)
//        if webViewStateModel.goToPage {
//            webViewStateModel.goToPage = false
//        }
//    }
//}
//
////extension WKWebView {
////    func load(_ htmlFileName: String) {
////        guard !htmlFileName.isEmpty else {
////            return print("Empty file name")
////        }
////        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
////            return print("Error file path")
////        }
////        
////        do {
////            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
////            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath ))
////        } catch {
////            print("error")
////        }
////    }
////}
