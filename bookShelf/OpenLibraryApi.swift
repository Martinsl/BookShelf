//
//  OpenLibraryApi.swift
//  Httprequest
//
//  Created by Lucas Martins on 11/04/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import Foundation

class OpenLibraryAPI {
  func loadAuthor(authorName: String, completion: ((result:Author) -> Void)!) { // -> String {
    let baseUrl = "http://openlibrary.org/search.json?author="
    let formatedName = String(map(authorName.lowercaseString.generate()) {
      $0 == " " ? "+" : $0
      })
    let urlString = baseUrl + formatedName
    var returnString = "Number of books: "

    let url = NSURL(string: urlString)
    let session = NSURLSession.sharedSession()

    
    var task = session.dataTaskWithURL(url!){(data, response, error) in

      if error != nil {
        println(error.localizedDescription)
      } else {
        let json = JSON(data: data)
        //println(json)
        if json["num_found"].intValue != 0 { // Test if the author exists
          var author = Author(name: authorName, numBooks: json["num_found"].intValue)
        
          //populate author books
          if let bookArray = json["docs"].array {
          
            var books = [BookAuthor]()
          
            for bookDict in bookArray {
              var bookTitle: String? = bookDict["title"].string
              var bookISBN: String? = bookDict["isbn"][0].string
            
              if bookTitle != nil && bookISBN != nil {
                var book = BookAuthor(title: bookTitle!, isbn: bookISBN!)
                author.books.append(book)
                //println(book.title)
              }
            }
          }
        
          println("Author's first book is " + author.books[0].title)
          println("With ISBN:" + author.books[0].isbn)
        
          //returnString += "\(author.numBooks)"
          completion(result: author)//returnString)
        } else {
          var author = Author(name: "Not Found", numBooks: json["0"].intValue)
          completion(result: author)
        }
      }
    }
    task.resume()
  }
  
  func loadBook(bookISBN: String, completion: ((result:Book) -> Void)!) { // -> String {
    let baseUrl = "https://openlibrary.org/api/books?bibkeys=ISBN:"
    let endUrl = "&jscmd=details&format=json"
    let urlString = baseUrl + bookISBN + endUrl
    
    let url = NSURL(string: urlString)
    let session = NSURLSession.sharedSession()
    
    
    var task = session.dataTaskWithURL(url!){(data, response, error) in
      
      if error != nil {
        println(error.localizedDescription)
      } else {
        let json = JSON(data: data)
        //println(json)
        
        //println(json["ISBN:\(bookISBN)"]["thumbnail_url"]) IMG URL
        let imageURL = json["ISBN:\(bookISBN)"]["thumbnail_url"].string
        var book = Book(isbn: bookISBN, imgUrl: imageURL)
        completion(result: book)
      }
    }
    task.resume()
  }
}