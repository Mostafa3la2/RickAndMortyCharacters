//
//  CharacterDetailsView.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import SwiftUI
import Kingfisher

struct CharacterDetailsView: View {

    var characterDetails: CharacterDetailsModel
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading,  spacing: 24) {
                        ImageHeaderView(geometry: geometry, image: characterDetails.image)
                        VStack(alignment: .leading) {
                            HStack {
                                CharacterNameLabel(name: characterDetails.name)
                                Spacer()
                                CharacterStatusLabel(status: characterDetails.status)
                            }

                            HStack {
                                CharacterSpeciesLabel(species: characterDetails.species)
                                Text(" • ")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                CharacterGenderLabel(gender: characterDetails.gender)
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        CharacterLocationLabel(location: characterDetails.location)
                            .padding(.leading, 16)
                    }
                    NavigationBackButton()
                }
                .toolbar(.hidden, for: .navigationBar)
            }
    }

}

#Preview {
    let characterDetails = CharacterDetailsModel(name: "Test", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", species: "Human", gender: "Male", location: "Earth C-137", status: "Alive")
    return CharacterDetailsView(characterDetails: characterDetails)
}

struct ImageHeaderView: View {

    var geometry: GeometryProxy!
    var imageURL: String?
    init(geometry: GeometryProxy!, image: String?) {
        self.geometry = geometry
        self.imageURL = image
    }
    var body: some View {
        KFImage(URL(string: imageURL ?? ""))
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.width-50)
            .clipShape(.rect(
                bottomLeadingRadius: 40,
                bottomTrailingRadius: 40
            ))
    }
}
struct CharacterNameLabel: View {
    var name: String?
    init(name: String?) {
        self.name = name
    }
    var body: some View {
        Text(name ?? "")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .lineLimit(2)
    }
}
struct CharacterSpeciesLabel: View {
    var species: String?
    init(species: String?) {
        self.species = species
    }
    var body: some View {
        Text(species ?? "")
            .font(.title3)
            .foregroundStyle(Color(DesignSystem.Colors.ExtraDarkGray.Color))
    }
}
struct CharacterStatusLabel: View {
    var status: String?
    init(status: String?) {
        self.status = status
    }
    var body: some View {
        Text(status ?? "")
            .padding(.all, 8)
            .background(Color(DesignSystem.Colors.BabyBlue.Color))
            .clipShape(.capsule)
    }
}
struct CharacterGenderLabel: View {
    var gender: String?
    init(gender: String?) {
        self.gender = gender
    }
    var body: some View {
        Text(gender ?? "")
            .font(.title3)
            .foregroundStyle(Color(DesignSystem.Colors.MediumGray.Color))
    }
}
struct CharacterLocationLabel: View {
    var location: String?
    init(location: String?) {
        self.location = location
    }
    var body: some View {
        HStack {
            Text("Location: ")
                .font(.title2)
                .fontWeight(.bold)
            Text(location ?? "")
                .foregroundStyle(Color(DesignSystem.Colors.ExtraDarkGray.Color))
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}
struct NavigationBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .padding(16)
                .background(Circle().fill(.white))
                .padding(.top, 40)
                .padding(.leading, 24)
                .shadow(radius: 2)
        }
        .accessibilityIdentifier("back")

    }
}
