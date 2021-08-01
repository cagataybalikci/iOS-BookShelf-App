//
//  BrowserVC.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 27.07.2021.
//

import UIKit
import WebKit

class BrowserVC: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var webView: WKWebView!
    
    let websites = ["google","amazon","facebook","youtube","twitter","apple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl(urlString: "https://www.google.com")
        
        searchController.searchBar.autocapitalizationType = .none
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search/Enter website"
        searchController.searchBar.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
        
        let backImage = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysTemplate)
        let bookmarkImage = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
        let forwardImage = UIImage(systemName: "chevron.forward")?.withRenderingMode(.alwaysTemplate)
        let refreshImage = UIImage(systemName: "arrow.clockwise")?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIBarButtonItem(image: backImage, style: .plain , target: self, action: #selector(backButtonPressed))
        let forwardButton = UIBarButtonItem(image: forwardImage, style: .plain , target: self, action: #selector(forwardButtonPressed))
        let refreshButton = UIBarButtonItem(image: refreshImage, style: .plain , target: self, action: #selector(refreshButtonPressed))
        let bookmarkButton = UIBarButtonItem(image: bookmarkImage, style: .plain , target: self, action: #selector(bookmarkButtonPressed))
        
        let appNameLabel = UILabel()
        appNameLabel.text = "BookShelf"
        appNameLabel.font = UIFont(name: "OpenSans-Bold", size: 20)
        appNameLabel.sizeToFit()
        
        
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: appNameLabel)
        self.navigationItem.rightBarButtonItems = [bookmarkButton,refreshButton,forwardButton,backButton]
        
        for button in self.navigationItem.rightBarButtonItems! {
            button.tintColor = #colorLiteral(red: 0.6235294118, green: 0.2549019608, blue: 0.2941176471, alpha: 1)
        }
        
        
        
    }
    
    func loadUrl(urlString: String){
        let myURL = URL(string:urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        searchController.searchBar.text = urlString
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let urlString = searchBar.text {
            if urlString.starts(with: "http://") || ((urlString.starts(with: "https://"))){
                loadUrl(urlString: urlString)
            }else if (urlString.starts(with: "www.") && urlString.hasSuffix(".com")){
                loadUrl(urlString: "https://\(urlString)")
            }else{
                loadUrl(urlString: "https://www.google.com/search?q=\(urlString)")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Browser Bookmark Section
    
    @objc func bookmarkButtonPressed(){
        let ac = UIAlertController(title: "Bookmarks", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website.capitalized, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://www.\(action.title!).com")!
        webView.load(URLRequest(url: url))
    }
    
    
    @objc func backButtonPressed(){
        if (self.webView.canGoBack){
            self.webView.goBack()
        }
    }
    
    @objc func forwardButtonPressed(){
        if (self.webView.canGoForward){
            self.webView.goForward()
        }
    }
    
    @objc func refreshButtonPressed(){
        self.webView.reload()
    }
    
    
    
    
    
}
