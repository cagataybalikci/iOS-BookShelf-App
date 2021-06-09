//
//  ViewController.swift
//  BookSelf
//
//  Created by Çağatay Balıkçı on 7.06.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var bookIds = [UUID]()
    var bookTitles = [String]()
    var authors = [String]()
    var bookCovers = [UIImage]()
    var pageNumbers = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Navigation Controller
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addBook))
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.8745098039, green: 0.337254902, blue: 0.3294117647, alpha: 1)
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "dataEntered"), object: nil)
    }
    
    //MARK: Segue To AddBookCV
    @objc func  addBook(){
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    //MARK: TableView Section
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as! BooksTableViewCell
        if bookIds.count > 0 {
            navigationController?.navigationBar.topItem?.title = "BookShelf"
            cell.authorLabel.text = authors[indexPath.row]
            cell.bookTitleLabel.text = bookTitles[indexPath.row]
            cell.bookImage.image = bookCovers[indexPath.row]
            cell.pageNumberLabel.text = String(pageNumbers[indexPath.row])
        }else{
            navigationController?.navigationBar.topItem?.title = "Add A Book"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookIds.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // Delete from Core Data
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
            fetchRequest.predicate = NSPredicate(format: "id=%@", bookIds[indexPath.row].uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == bookIds[indexPath.row] {
                                context.delete(result)
                                bookIds.remove(at: indexPath.row)
                                bookTitles.remove(at: indexPath.row)
                                authors.remove(at: indexPath.row)
                                bookCovers.remove(at: indexPath.row)
                                pageNumbers.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do {
                                    try context.save()
                                } catch {
                                    print("Error")
                                }
                                break
                            }
                        }
                    }
                }
            } catch {
                print("Error")
            }
            
        }
        
        
        
    }
    
    //MARK: Pull Data From Core Data
    
    @objc func getData(){
        bookIds.removeAll(keepingCapacity: false)
        bookTitles.removeAll(keepingCapacity: false)
        authors.removeAll(keepingCapacity: false)
        bookCovers.removeAll(keepingCapacity: false)
        pageNumbers.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        fetchRequest.returnsObjectsAsFaults = true
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let booktitle = result.value(forKey: "bookName") as? String {
                    bookTitles.append(booktitle)
                }
                
                if let author = result.value(forKey: "author") as? String{
                    authors.append(author)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    bookIds.append(id)
                }
                
                if let bookImage = result.value(forKey: "image") as? Data{
                    let imageFromData = UIImage(data: bookImage)
                    bookCovers.append(imageFromData!)
                }
                
                if let pageNumber = result.value(forKey: "pageNumber") as? Int{
                    pageNumbers.append(pageNumber)
                }
            }
            tableView.reloadData()
        } catch {
            print("Error")
        }
    }
}

