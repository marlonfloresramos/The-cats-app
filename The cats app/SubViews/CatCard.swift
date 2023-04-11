//
//  CatCard.swift
//  The cats app
//
//  Created by Marlon Gabriel Flores Ramos on 11/04/23.
//

import SwiftUI

struct CatCard: View {
    let cat: Cat
    @Binding var isLoadingImage: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            VStack {
                Text(cat.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(isLoadingImage ? .black : .gray)
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
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.white)
                                .shadow(radius: 10)
                            Text("Pais de origen")
                                .fontWeight(.bold)
                        }
                        Text(cat.origin ?? "")
                    }
                    Spacer()
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.white)
                                .shadow(radius: 10)
                            Text("Inteligencia")
                                .fontWeight(.bold)
                        }
                        Text(String(cat.intelligence ?? 0))
                    }
                }
            }
            .padding(20)
        }
        .frame(maxWidth: 300)
    }
}

struct CatCard_Previews: PreviewProvider {
    static var previews: some View {
        CatCard(cat: Cat(id: "abys", name: "Abyssinian", origin: "Egypt", intelligence: 5, imageURL: CatImage(url: "https://cdn2.thecatapi.com/images/VZ3qFLIe3.jpg")), isLoadingImage: .constant(true))
    }
}
