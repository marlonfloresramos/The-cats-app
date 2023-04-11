//
//  CatsViewModel.swift
//  The cats app
//
//  Created by Marlon Gabriel Flores Ramos on 11/04/23.
//

import SwiftUI

class CatsViewModel: ObservableObject {
    let networkingManager: ApiCats
    @Published var cats = [Cat]()
    
    init(networkingManager: ApiCats) {
        self.networkingManager = networkingManager
    }
    
    func getCats() {
        Task { @MainActor in
            do {
                cats = try await networkingManager.getCats()
            } catch {
                print(error)
            }
        }
    }
}

