//
//  DetailViewController.swift
//  Project4
//
//  Created by Jessica Bommer on 20/9/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

        let goBack = UIBarButtonItem(barButtonSystemItem: .action, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(barButtonSystemItem: .action, target: webView, action: #selector(webView.goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [goBack, goForward, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
//        let url = URL(string: "https://" + websites[0])!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
