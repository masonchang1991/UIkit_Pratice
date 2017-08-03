//
//  WKWebViewController.swift
//  UIKitPractice_week_2
//
//  Created by Ｍason Chang on 2017/8/3.
//  Copyright © 2017年 Ｍason Chang iOS#4. All rights reserved.
//

import UIKit
import WebKit


class WKWebViewController: UIViewController, WKNavigationDelegate {

    
    var webview = WKWebView()
    
    var pageString = ["GOGOPOWER", "bang", "wow"]
    
    var pageContainer = [UIView]()
    
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        let leftNCButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(self.back))
        
        self.navigationItem.leftBarButtonItem = leftNCButton
        
        let rightNCButton = UIBarButtonItem(title: "Go", style: .plain, target: self, action: #selector(self.go))
        
        self.navigationItem.rightBarButtonItem = rightNCButton
        
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        let statusHeight = UIApplication.shared.statusBarFrame.height
        
        
//        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let webview = WKWebView(frame: CGRect(x: 0, y: statusHeight+navHeight!, width: self.view.frame.width, height: self.view.frame.height))
        

        let url = NSURL(string: "http://www.jianshu.com/users/040395b7230c/latest_articles")
        
        let request = NSURLRequest(url: url! as URL)
        
        webview.load(request as URLRequest)
        
        self.view.addSubview(webview)
        
        self.webview.navigationDelegate = self
        

    }
    
    func back() {
        
        self.view.subviews[view.subviews.count - 1].removeFromSuperview()
        
        
    }
    
    
    func go() {
        
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        let statusHeight = UIApplication.shared.statusBarFrame.height

        
        let webview1 = WKWebView(frame: CGRect(x: 0, y: statusHeight+navHeight!, width: self.view.frame.width, height: self.view.frame.height))
        
        
        let url = NSURL(string: "http://www.google.com/search?q=\(pageString[count])")
        
        let request = NSURLRequest(url: url! as URL)
        
        webview1.load(request as URLRequest)
        
        self.view.addSubview(webview1)

        count += 1
        
        if count == 3 {
            count = 0
        }
        
    }
    

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print(self.webview.title)
        
        self.navigationItem.title = self.webview.title
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
