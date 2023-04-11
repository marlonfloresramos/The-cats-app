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
            LazyVStack {
                ForEach(viewModel.cats) { cat in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(.white)
                                        .shadow(radius: 10)
                        VStack {
                            Text(cat.name ?? "")
                            AsyncImage(
                                url: URL(string: cat.imageURL?.url ?? ""),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 200)
                                },
                                placeholder: {
                                    ProgressView()
                                        .frame(width: 200, height: 200)
                                })
                            HStack {
                                VStack {
                                    Text("Pais de origen")
                                    Text(cat.origin ?? "")
                                }
                                Spacer()
                                VStack {
                                    Text("Inteligencia")
                                    Text(String(cat.intelligence ?? 0))
                                }
                            }
                        }
                        .padding(20)
                    }
                    .frame(maxWidth: 300)
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
