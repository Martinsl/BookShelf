//
//  Book.swift
//  Httprequest
//
//  Created by Lucas Martins on 11/04/2015.
//  Copyright (c) 2015 Lucas Martins. All rights reserved.
//

import Foundation

class Book{
  var title: String!
  //var languages: [String]!
  var isbn: String!
  var imgUrl: String!
  //var publishYear: Int!
  
  init(isbn: String, imgUrl: String){
    self.imgUrl = imgUrl
    self.isbn = isbn
  }
}