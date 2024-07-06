//
//  CharacterDetailsView.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import SwiftUI
import Kingfisher

struct CharacterDetailsView: View {

    // var characterItem: CharacterListItemViewModel
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    VStack(alignment: .leading,  spacing: 24) {
                        ImageHeaderView(geometry: geometry)
                        VStack(alignment: .leading) {
                            HStack {
                                CharacterNameLabel()
                                Spacer()
                                Text("Status")
                                    .padding(.all, 8)
                                    .background(.cyan)
                                    .clipShape(.capsule)
                            }

                            HStack {
                                CharacterSpeciesLabel()
                                Text(" • ")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                CharacterGenderLabel()
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        CharacterLocationLabel()
                            .padding(.leading, 16)
                    }

                }
                .toolbar(.hidden, for: .navigationBar)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    CharacterDetailsView()
}

struct ImageHeaderView: View {
    var geometry: GeometryProxy!

    init(geometry: GeometryProxy!) {
        self.geometry = geometry
    }
    var body: some View {
        KFImage(URL(string: "https://picsum.photos/200/300"))
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.width-50)
            .clipShape(.rect(
                topLeadingRadius: 40,
                bottomLeadingRadius: 40,
                bottomTrailingRadius: 40,
                topTrailingRadius: 40
            ))
    }
}
struct CharacterNameLabel: View {
    var body: some View {
        Text("Name")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .lineLimit(2)
    }
}
struct CharacterSpeciesLabel: View {
    var body: some View {
        Text("Species")
            .font(.title3)
    }
}
struct CharacterGenderLabel: View {
    var body: some View {
        Text("Gender")
            .font(.title3)
            .foregroundStyle(.gray)
    }
}
struct CharacterLocationLabel: View {
    var body: some View {
        HStack {
            Text("Location: ")
                .font(.title2)
                .fontWeight(.bold)
            Text("Location")
                .foregroundStyle(.gray)
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}
