//
//  ViewController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 7.06.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var bookArray = [UIImage(named: "lostsymbol"),UIImage(named: "lepassager")]
    var bookTitleArray = ["Lost Symbol","La Passager"]
    var bookPageNumber = ["528","680"]
    var authorArray = ["Dan Brown","Jean-Christophe Grangé"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Navigation Controller
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addBook))
    }
    
    
    @objc func  addBook(){
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as! BooksTableViewCell
        cell.bookImage.image = bookArray[indexPath.row]
        cell.bookTitleLabel.text = bookTitleArray[indexPath.row]
        cell.pageNumberLabel.text = bookPageNumber[indexPath.row] + " pages"
        cell.authorLabel.text = authorArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
}

