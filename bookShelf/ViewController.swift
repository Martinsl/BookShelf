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
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  lazy var items = [String]()
  
  let api = OpenLibraryAPI()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func searchAuthor(sender : AnyObject) {
    // TODO: Pass object to TableViewController
    if let authorNameText = authorNameField.text {
      if authorNameText != "" {
        activityIndicator.startAnimating()
        
        let searchResult = api.loadAuthor(authorNameText){ (authorFound) -> Void in
          
          if authorFound.name != "Not Found" {
            dispatch_async(dispatch_get_main_queue()) {
              self.activityIndicator.stopAnimating()
              var VC1 = self.storyboard?.instantiateViewControllerWithIdentifier("tableBooks") as! TableViewController
              VC1.authorFound = authorFound
              let _ = self.navigationController?.showViewController(VC1, sender: nil)
            }
          } else {
            dispatch_async(dispatch_get_main_queue()) {
              let alertController = UIAlertController(title: "Error", message:
                "Author not Found", preferredStyle: UIAlertControllerStyle.Alert)
              alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
              
              self.presentViewController(alertController, animated: true, completion: nil)
              self.activityIndicator.stopAnimating()
            }
          }
        }
      } else {
        let alertController = UIAlertController(title: "Error", message:
          "Name not provided", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}