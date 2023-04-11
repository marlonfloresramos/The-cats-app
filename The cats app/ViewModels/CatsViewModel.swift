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
            } catch {
                print(error)
            }
        }
    }
    
    func getImages() async {
        Task { @MainActor in
            for (index, cat) in cats.enumerated() {
                isLoadingImages = true
                do {
                    let imageCat = try? await networkingManager.getCatImageURL(with: cat.id ?? "")
                    cats[index].imageURL = imageCat?.first
                    isLoadingImages = false
                }
            }
        }
    }
}

