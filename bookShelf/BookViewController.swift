//
//  BookViewController.swift
//  Httprequest
//
//  Created by Lucas Martins on 12/05/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  let api = OpenLibraryAPI()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    loadImage("https://covers.openlibrary.org/b/id/2655619-S.jpg")
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