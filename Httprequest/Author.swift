//
//  Author.swift
//  Httprequest
//
//  Created by Lucas Martins on 11/04/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import Foundation

class Author{
  var name: String!
  var numBooks: Int!
  var books: [BookAuthor]!
  
  init(){
    
  }
  
  init(name: String, numBooks: Int){
    self.name = name
    self.numBooks = numBooks
    self.books = []
  }
}