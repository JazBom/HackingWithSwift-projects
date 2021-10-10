//
//  ViewController.swift
//  Project4
//
//  Created by Jessica Bommer on 20/9/21.
//

import UIKit
import WebKit


class ViewController: UITableViewController, WKNavigationDelegate {

    // MARK: - Public variables
//    var webView: WKWebView!
    var websites = ["apple.com",
                    "hackingwithswift.com",
                    "jessicabommer.com"]

    // MARK: - Lifecycle functions

//    override func loadView() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
    }

    // MARK: - custom functions
//    @objc func openTapped(){
//        let alert = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
//        for website in websites {
//            alert.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
//        }
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: openPage))
//        alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(alert, animated: true)
//    }

//    func openPage(action: UIAlertAction) {
//
//        guard let actionTitle = action.title else { return }
//
//        guard let url = URL(string: "https://" + actionTitle) else {
//            let alert = UIAlertController(title: "Error", message: "This website is blocked", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: true)
//            return
//        }
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//        webView.load(URLRequest(url:url))
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        title = webView.title
//    }

//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "estimatedProgress" {
//            progressView.progress = Float(webView.estimatedProgress)
//        }
//    }

//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        let url = navigationAction.request.url
//
//        if let host = url?.host {
//            for website in websites {
//                if host.contains(website) {
//                    decisionHandler(.allow)
//                    return
//                }
//            }
//        }
//        decisionHandler(.cancel)
//    }

    // MARK: - Delegate functions

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        openPage(action: nil)
//    }
}

