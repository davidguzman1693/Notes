//
//  Nota.swift
//  MyNotes
//
//  Created by Aplimovil on 12/8/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import Foundation

struct Nota {
    
    var title: String!
    var date: String!
    var descripcion: String!
    
    init (title:String, date:String, descripcion:String){
        self.descripcion = descripcion
        self.title = title
        self.date = date
    }
    
}
