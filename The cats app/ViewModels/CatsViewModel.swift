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
    @Published var isLoadingImages = false
    @Published var cats = [Cat]()
    
    init(networkingManager: ApiCatRepresentable) {
        self.networkingManager = networkingManager
    }
    
    func getCats() {
        Task { @MainActor in
            isLoading = true
            do {
                cats = try await networkingManager.getCats()
                isLoading = false
                await getImages()
                isLoadingImages = false
            } catch {
                print(error)
            }
        }
    }
    
    func getImages() async {
        isLoadingImages = true
        for (index, cat) in cats.enumerated() {
            do {
                let imageCat = try? await networkingManager.getCatImageURL(with: cat.id ?? "")
                cats[index].imageURL = imageCat?.first
            }
        }
    }
}

