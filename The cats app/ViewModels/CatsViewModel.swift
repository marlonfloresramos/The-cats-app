//
//  CatsViewModel.swift
//  The cats app
//
//  Created by Marlon Gabriel Flores Ramos on 11/04/23.
//

import SwiftUI

class CatsViewModel: ObservableObject {
    let networkingManager: ApiCatRepresentable
    
    @Published var isLoading = false
    @Published var cats = [Cat]()
    
    init(networkingManager: ApiCatRepresentable) {
        self.networkingManager = networkingManager
    }
    
    func getCats() {
        isLoading = true
        Task { @MainActor in
            do {
                cats = try await networkingManager.getCats()
                isLoading = false
            } catch {
                print(error)
            }
        }
    }
}

