//
//  ContentView.swift
//  appTest1
//
//  Created by 백승기 on 2022/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var keyboardMonitor : KeyboardMonitor = KeyboardMonitor()
    
    var body: some View {
        WebView(url: "http://192.168.0.48:1024/").edgesIgnoringSafeArea(.all)
//        WebUIView(htmlFileName: "html/index").edgesIgnoringSafeArea(.all)
        if (keyboardMonitor.keyboardHeight > 0) {
            Spacer().frame(height: 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
