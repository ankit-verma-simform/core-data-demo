//
//  Friend.swift
//  CoreDataDemo
//
//  Created by Ankit Verma on 27/07/23.
//

import Foundation

 struct Friend {
     let id: UUID
     var name: String

     init(id: UUID = UUID(), name: String) {
         self.id = id
         self.name = name
     }
 }
