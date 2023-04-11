//
//  Cat.swift
//  The cats app
//
//  Created by Marlon Gabriel Flores Ramos on 11/04/23.
//

import Foundation

class Cat: Decodable, Identifiable {
    let id: String?
    let name: String?
    let origin: String?
    let intelligence: Int?
    var imageURL: CatImage?
    
    init(id: String?, name: String?, origin: String?, intelligence: Int?, imageURL: CatImage? = nil) {
        self.id = id
        self.name = name
        self.origin = origin
        self.intelligence = intelligence
        self.imageURL = imageURL
    }
}

class CatImage: Decodable {
    let url: String?
    
    init(url: String?) {
        self.url = url
    }
}

