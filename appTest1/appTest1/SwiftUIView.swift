import SwiftUI
import WebKit

// UIViewRepresentable
struct WebUIView: UIViewRepresentable {
    var url: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.evaluateJavaScript("aa()", completionHandler: {(result, error) in
            if let result = result {
                print(result)
            }
        })
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
//        webView.load(htmlFileName)
    }
}
extension WKWebView {
    func load(_ htmlFileName: String) {
        guard !htmlFileName.isEmpty else {
            return print("Empty file name")
        }
        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
            return print("Error file path")
        }
        
        do {
            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath ))
        } catch {
            print("error")
        }
    }
}

// Coordinator
class Coordinator : NSObject {

    var parent: WebUIView

    init(_ parent: WebUIView) {
        self.parent = parent
    }
}

// WKNavigationDelegate
extension Coordinator: WKNavigationDelegate {

    func webView(_ webView: WKWebView,
                   decidePolicyFor navigationAction: WKNavigationAction,
                   decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        decisionHandler(.allow)
    }
}

// WKUIDelegate
extension Coordinator: WKUIDelegate {

}

// View
struct WebView: View {
    let url: String

    var body: some View {
        WebUIView(url: url)
//        WebUIView(htmlFileName: "html/index")
    }
}

// Preview
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "http://192.168.0.48:8080").edgesIgnoringSafeArea(.all)
//        WebUIView(htmlFileName: "html/index")
    }
}
