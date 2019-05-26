//
//  WebViewViewController.swift
//  News Reader
//
//  Created by macOS Mojave on 26/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    @IBOutlet weak var webview: WKWebView!
    var name: String?
    var urlString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(name as Any)
        print("urlString is:",urlString as Any)
        //let request = URLRequest(url: url!)
        webview.load(URLRequest(url: URL(string: urlString!)!))
        //webview.load(request)
    }
    
}
