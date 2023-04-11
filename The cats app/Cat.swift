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
}

class CatImage: Decodable {
    let url: String?
}

