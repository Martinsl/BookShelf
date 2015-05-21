//
//  BookViewController.swift
//  Httprequest
//
//  Created by Lucas Martins on 12/05/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var bookFound:Book!
  let api = OpenLibraryAPI()
  var authorName:String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    
    titleLabel.text = "Title: \(bookFound.title)"
    authorLabel.text = "Author: \(authorName)"
    activityIndicator.startAnimating()
    if var url:String = bookFound.imgUrl {
      url = url.substringToIndex(advance(url.startIndex, count(url)-5)) + "M.jpg"
      loadImage(url)
    }
    activityIndicator.stopAnimating()
  }
  
  func loadImage(urlString:String){
    
    
    var imgURL: NSURL = NSURL(string: urlString)!
    let request: NSURLRequest = NSURLRequest(URL: imgURL)
    NSURLConnection.sendAsynchronousRequest(
      request, queue: NSOperationQueue.mainQueue(),
      completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
        if error == nil {
          self.imageView.image = UIImage(data: data)
        }
    })
  }
}