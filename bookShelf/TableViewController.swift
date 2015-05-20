//
//  TableViewController.swift
//  Httprequest
//
//  Created by Lucas Martins on 07/05/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

  @IBOutlet weak var actIndicator: UIActivityIndicatorView!
  
  var items = [String]()
  var authorFound: Author!
  let api = OpenLibraryAPI()
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.authorFound.books.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
    
    cell.textLabel?.text = authorFound.books[indexPath.row].title
    
    return cell
    
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let isbn = authorFound.books[indexPath.row].isbn
    let title = authorFound.books[indexPath.row].title
    println("Book ISBN is : \(isbn)")
    
    actIndicator.startAnimating()
    let searchResult = api.loadBook(isbn){ (bookFound) -> Void in
      //println(bookFound.imgUrl)
      bookFound.title = title
      
      dispatch_async(dispatch_get_main_queue()) {
        self.actIndicator.stopAnimating()
        var VC1 = self.storyboard?.instantiateViewControllerWithIdentifier("bookInfo") as! BookViewController
        VC1.bookFound = bookFound
        VC1.authorName = self.authorFound.name
        
        let _ = self.navigationController?.showViewController(VC1, sender: nil)
      }
    }
  }
}
