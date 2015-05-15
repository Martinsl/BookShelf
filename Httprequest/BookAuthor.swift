//
//  BookAuthor.swift
//  Httprequest
//
//  Created by Lucas Martins on 03/05/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import Foundation

class BookAuthor{
  var title: String!
  var isbn: String!
  //var languages: [String]!
  
  init(){
    
  }
  
  init(title: String, isbn: String){
    self.title = title
    self.isbn = isbn
  }
}