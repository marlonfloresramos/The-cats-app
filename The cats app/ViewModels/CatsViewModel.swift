//
//  CatsViewModel.swift
//  The cats app
//
//  Created by Marlon Gabriel Flores Ramos on 11/04/23.
//

import SwiftUI

class CatsViewModel: ObservableObject {
    let networkingManager: ApiCatRepresentable
    @Published var cats = [Cat]()
    
    init(networkingManager: ApiCatRepresentable) {
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

