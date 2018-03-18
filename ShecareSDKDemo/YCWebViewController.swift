//
//  YCWebViewController.swift
//  EasyAtHome
//
//  Created by 北京爱康泰科技有限责任公司 on 2017/6/27.
//  Copyright © 2017年 北京爱康泰科技有限责任公司. All rights reserved.
//

import UIKit
import WebKit

class YCWebViewController: UIViewController {
    
    var urlString = ""
    fileprivate lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.view.addSubview(webView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url,
                                     cachePolicy: .reloadIgnoringLocalCacheData,
                                     timeoutInterval: 15)
            webView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(NSStringFromClass(type(of: self)) + "---" + #function)
    }
    
    deinit {
        print(NSStringFromClass(type(of: self)) + "---" + #function)
    }
}

extension YCWebViewController: WKNavigationDelegate {
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}
