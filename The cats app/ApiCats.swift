//
//  ApiCats.swift
//  The cats app
//
//  Created by Marlon Gabriel Flores Ramos on 11/04/23.
//

import Foundation

enum RequestError: Error {
    case genericError
}

class ApiCats {
    func getCats() async throws -> [Cat] {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=10") else  {throw RequestError.genericError}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bda53789-d59e-46cd-9bc4-2936630fde39", forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let cats = try decoder.decode([Cat].self, from: data)
            for (index, cat) in cats.enumerated() {
                do {
                    let imageCat = try? await getCatImageURL(with: cat.id ?? "")
                    cats[index].imageURL = imageCat?.first
                }
            }
            return cats
        } catch {
            throw RequestError.genericError
        }
    }
    
    func getCatImageURL(with id: String) async throws -> [CatImage] {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?breed_ids=\(id)&limit=1") else {throw RequestError.genericError}
        var request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let imageURL = try decoder.decode([CatImage].self, from: data)
            return imageURL
        } catch let error {
            print(error)
            throw RequestError.genericError
        }
    }
}
