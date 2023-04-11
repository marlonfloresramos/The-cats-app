//
//  ContentView.swift
//  The cats app
//
//  Created by Marlon Gabriel Flores Ramos on 11/04/23.
//

import SwiftUI

struct CatsView: View {
    @ObservedObject var viewModel: CatsViewModel
    
    var body: some View {
        ScrollView {
            Text("Catbreeds")
                .font(.title)
            if viewModel.isLoading {
                ProgressView()
            } else {
                LazyVStack {
                    ForEach(viewModel.cats) { cat in
                        CatCard(cat: cat, isLoadingImage: $viewModel.isLoadingImages)
                    }
                }
            }
            
        }
        .onAppear {
            viewModel.getCats()
        }
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView(viewModel: CatsViewModel(networkingManager: MockedApiCats()))
    }
}
