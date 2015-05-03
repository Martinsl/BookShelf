//
//  ViewController.swift
//  Httprequest
//
//  Created by Lucas Martins on 11/04/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var authorNameField: UITextField!
  @IBOutlet var searchButton: UIButton!
  @IBOutlet weak var showResult: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var tableView: UITableView!

  let api = OpenLibraryAPI()

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func searchAuthor(sender : AnyObject) {
    
    if let authorNameText = authorNameField.text {
      if authorNameText != "" {
        activityIndicator.startAnimating()
        
        
        let searchResult = api.loadAuthor(authorNameText){ (authorFound) -> Void in
          
          var authorBooks: [String] = []
          for book in authorFound.books {
            authorBooks.append(book.title)
          }
          
          self.activityIndicator.stopAnimating()
          self.showResult.text = "Number of books: \(authorFound.numBooks)"//\(authorBooks)"
        }
      } else {
        self.showResult.text = "Author Name not provided"
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}